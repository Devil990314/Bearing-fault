function [ifeat,testStat,testStat_rand,featureClassifier] = TS_TopFeatures(whatData,whatTestStat,cfnParams,varargin)
% TS_TopFeatures  Top individual features for discriminating labeled time series
%
% This function compares each feature in an hctsa dataset individually for its
% ability to separate the labeled classes of time series according to a given
% test statistic.
%
% Can also compare this performance to a set of randomized null features to
% evaluate the statistical significance of the result (pooled permutation testing).
%
% Note that it can be more interpretable to run this function on filtered but
% un-normalized data (e.g., from TS_Normalize('none')), so that feature values
% correspond to raw feature outputs.
%
%---INPUTS:
%
% whatData, the hctsa data to use (input to TS_LoadData, default: 'raw')
% whatTestStat, the test statistic to quantify the goodness of each feature
%               (e.g., 'tstat','ustat'; or set 'classification' to use classifier
%                   described in cfnParams)
% cfnParams, the classification settings if using 'classification'-based selection
%
%---OPTIONAL extra inputs:
%
% 'whatPlots', can specify what output plots to produce (cell of strings), e.g.,
%               specify {'histogram','distributions','cluster','datamatrix'} to
%               produce all four possible output plots (this is the default).
% 'numTopFeatures' [40], specifies the number of top features to analyze, both in
%                   terms of the list of outputs, the histogram plots, and the
%                   cluster plot.
% 'numFeaturesDistr' [16], sets a custom number of distributions to display (can
%                   set this lower to avoid producing large numbers of figures).
% 'numNulls' [0], the number of shuffled nulls to generate (e.g., 10 shuffles pools
%               shuffles for all M features, for a total of 10*M elements in the
%               null distribution)
%
%---EXAMPLE USAGE:
%
% TS_TopFeatures('norm','ustat',struct(),'whatPlots',{'histogram','distributions',...
%           'cluster','datamatrix'},'numTopFeatures',40,'numFeaturesDistr',10,'numNulls',10);
%
% TS_TopFeatures('norm','classification',cfnParams,'whatPlots',{'histogram','distributions',...
%           'cluster','datamatrix'},'numTopFeatures',40,'numFeaturesDistr',10,'numNulls',10);
%
%---OUTPUTS:
%
% ifeat, the ordering of operations by their performance
% testStat, the test statistic (whatTestStat) for each operation
% testStat_rand, test statistics making up the null distributions
% featureClassifier, the individual-feature classifier (if using single-feature
%               classification)

% ------------------------------------------------------------------------------
% Copyright (C) 2020, Ben D. Fulcher <ben.d.fulcher@gmail.com>,
% <http://www.benfulcher.com>
%
% If you use this code for your research, please cite the following two papers:
%
% (1) B.D. Fulcher and N.S. Jones, "hctsa: A Computational Framework for Automated
% Time-Series Phenotyping Using Massive Feature Extraction, Cell Systems 5: 527 (2017).
% DOI: 10.1016/j.cels.2017.10.001
%
% (2) B.D. Fulcher, M.A. Little, N.S. Jones, "Highly comparative time-series
% analysis: the empirical structure of time series and their methods",
% J. Roy. Soc. Interface 10(83) 20130048 (2013).
% DOI: 10.1098/rsif.2013.0048
%
% This work is licensed under the Creative Commons
% Attribution-NonCommercial-ShareAlike 4.0 International License. To view a copy of
% this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/ or send
% a letter to Creative Commons, 444 Castro Street, Suite 900, Mountain View,
% California, 94041, USA.
% ------------------------------------------------------------------------------

%-------------------------------------------------------------------------------
%% Check inputs and set defaults
%-------------------------------------------------------------------------------
if nargin < 1 || isempty(whatData)
    whatData = 'norm';
end
% Set other defaults later when we know what we're dealing with

% Use an inputParser to control additional options as parameters:
inputP = inputParser;
% whatPlots
default_whatPlots = {'histogram','distributions','dendrogram','cluster'}; % 'datamatrix'
check_whatPlots = @(x) iscell(x) || ischar(x);
addParameter(inputP,'whatPlots',default_whatPlots,check_whatPlots);
% numTopFeatures
default_numTopFeatures = 40;
addParameter(inputP,'numTopFeatures',default_numTopFeatures,@isnumeric);
% numFeaturesDistr
default_numFeaturesDistr = 16;
addParameter(inputP,'numFeaturesDistr',default_numFeaturesDistr,@isnumeric);
% numNulls
default_numNulls = 0; % by default, don't compute an empirical null distribution
                      % by randomizing class labels
addParameter(inputP,'numNulls',default_numNulls,@isnumeric);

parse(inputP,varargin{:});

whatPlots = inputP.Results.whatPlots;
if ischar(whatPlots)
    whatPlots = {whatPlots};
end
numTopFeatures = inputP.Results.numTopFeatures;
numFeaturesDistr = inputP.Results.numFeaturesDistr;
numNulls = inputP.Results.numNulls;
clear('inputP');

%-------------------------------------------------------------------------------
%% Load the data
%-------------------------------------------------------------------------------
[TS_DataMat,TimeSeries,Operations,whatDataFile] = TS_LoadData(whatData);

%-------------------------------------------------------------------------------
%% Checks
%-------------------------------------------------------------------------------
% Does the grouping information exist?:
% Assign group labels (removing unlabeled data):
[TS_DataMat,TimeSeries] = FilterLabeledTimeSeries(TS_DataMat,TimeSeries);
[groupLabels,classLabels,groupLabelsInteger,numClasses] = TS_ExtractGroupLabels(TimeSeries);
% Give basic info about the represented classes:
TellMeAboutLabeling(TimeSeries);

%-------------------------------------------------------------------------------
% Set defaults for the test statistic:
if nargin < 2 || isempty(whatTestStat)
    if numClasses == 2
        % ustat or ttest are way faster than proper prediction models
        whatTestStat = 'ustat';
    else
        whatTestStat = 'classification';
    end
    fprintf(1,'Using ''%s'' test statistic by default.\n', whatTestStat);
end
% Set cfnParams default (if using 'classification') later after loading the time series
if strcmp(whatTestStat,'classification')
    if nargin < 3 || isempty(fieldnames(cfnParams))
        cfnParams = GiveMeDefaultClassificationParams(TimeSeries);
        cfnParams.whatClassifier = 'fast-linear';
        cfnParams = UpdateClassifierText(cfnParams);
    end
else
    cfnParams = struct();
end

%-------------------------------------------------------------------------------
% Filter down to reduced features if specified/required:
[TS_DataMat,Operations] = FilterFeatures(TS_DataMat,Operations,cfnParams);
numFeatures = size(TS_DataMat,2);
numTopFeatures = min(numTopFeatures,numFeatures);

%-------------------------------------------------------------------------------
%% Define the train/test classification rate function, fn_testStat
%-------------------------------------------------------------------------------
% chanceLevel -- what you'd expect by chance

% Check that simple stats are being applied just for pairs:
if ismember(whatTestStat,{'ustat','ranksum','ustatExact','ustatP','ranksumExact',...
                            'ttest','ttestP','tstat','svmBeta'})
    if numClasses~=2
        error(['There are %u labeled classes.\nStatistics like ''%s'' are only valid',...
                    ' for problems with 2 labeled classes'],numClasses,whatTestStat);
    end
end

% Set up the test statistic computation and relevant description text:
switch whatTestStat
    case 'classification'
        % Set up the loss function for a classifier-based metric:
        fn_testStat = GiveMeFunctionHandle(cfnParams);
        chanceLevel = 100/numClasses; % (could be a bad assumption: accuracy for equiprobable groups...)
        testStatText = sprintf('%s %s',cfnParams.classifierText,cfnParams.whatLoss);
        statUnit = cfnParams.whatLossUnits;
        whatIsBetter = 'high';
    case 'svmBeta'
        % Feature weight from a linear (in-sample) SVM
        fn_testStat = [];
        chanceLevel = NaN;
        testStatText = '(multivariate) Linear SVM (in-sample) feature weight';
        statUnit = '';
        whatIsBetter = 'abs';
    case {'ustatP','ranksumP'}
        % Approximate p-value from ranksum test
        fn_testStat = @(XTrain,yTrain,Xtest,yTest) ...
                fn_uStat(XTrain(yTrain==classLabels{1}),XTrain(yTrain==classLabels{2}),false,true,false);
        chanceLevel = NaN;
        testStatText = 'Mann-Whitney approx p-value';
        statUnit = ' (-log10(p))';
        whatIsBetter = 'high';
    case {'ustatPsign','ranksumPsign'}
        % Approximate p-value from ranksum test, signed by the direction of difference
        fn_testStat = @(XTrain,yTrain,Xtest,yTest) ...
                fn_uStat(XTrain(yTrain==classLabels{1}),XTrain(yTrain==classLabels{2}),false,true,true);
        chanceLevel = NaN;
        testStatText = 'Mann-Whitney approx p-value (signed)';
        statUnit = ' signed(-log10(p))';
        whatIsBetter = 'abs';
    case {'ustatExactP','ranksumExactP'}
        % Exact p-value from ranksum test
        fn_testStat = @(XTrain,yTrain,Xtest,yTest) ...
                    fn_uStat(XTrain(yTrain==classLabels{1}),XTrain(yTrain==classLabels{2}),true,true,false);
        chanceLevel = NaN;
        testStatText = 'Mann-Whitney exact p-value';
        statUnit = ' (-log10(p))';
        whatIsBetter = 'high';
    case {'ustat','ranksum'}
        % Approximate test statistic from ranksum test
        fn_testStat = @(XTrain,yTrain,Xtest,yTest) ...
                fn_uStat(XTrain(yTrain==classLabels{1}),XTrain(yTrain==classLabels{2}),false,false,false);
        chanceLevel = NaN; % (check if you can compute the chance level stat?)
        testStatText = 'Mann-Whitney approx test statistic';
        statUnit = '';
        whatIsBetter = 'high';
    case {'ttest','tstat'}
        fn_testStat = @(XTrain,yTrain,Xtest,yTest) ...
                        fn_tStat(XTrain(yTrain==classLabels{1}),XTrain(yTrain==classLabels{2}),false);
        chanceLevel = 0; % chance-level t statistic is zero
        testStatText = 'Welch''s t-stat';
        statUnit = '';
        whatIsBetter = 'abs';
    case {'ttestP','tstatP'}
        fn_testStat = @(XTrain,yTrain,Xtest,yTest) ...
                        fn_tStat(XTrain(yTrain==classLabels{1}),XTrain(yTrain==classLabels{2}),true);
        chanceLevel = NaN;
        testStatText = 'Welch''s t-test p-value';
        statUnit = ' (-log10(p))';
        whatIsBetter = 'high';
    otherwise
        error('Unknown test statistic: ''%s''',whatTestStat);
end

%-------------------------------------------------------------------------------
%% Loop over all features
%-------------------------------------------------------------------------------
% Use the same data for training and testing:
fprintf(1,['Computing the performance of %u individual features to differentiate',...
                ' %u classes using a %s...\n'],...
                        height(Operations),numClasses,testStatText);
timer = tic;
testStat = giveMeStats(TS_DataMat,TimeSeries.Group,true);
fprintf(1,' Done in %s.\n',BF_TheTime(toc(timer)));

if all(isnan(testStat))
    error('Error computing test statistics for %s (maybe there are missing data?)',...
                testStatText);
end

%-------------------------------------------------------------------------------
% Give mean and that expected from random classifier (there may be a little overfitting)
if ~isnan(chanceLevel)
    fprintf(1,['Mean %s across %u features = %4.2f%s\n' ...
            '(Random guessing for %u equiprobable classes = %4.2f%s)\n'], ...
        testStatText,numFeatures,nanmean(testStat),statUnit,numClasses,chanceLevel,statUnit);
else
    fprintf(1,'Mean %s across %u features = %4.2f%s\n',...
        testStatText,numFeatures,nanmean(testStat),statUnit);
end

%-------------------------------------------------------------------------------
%% Display information about the top features (numTopFeatures)
%-------------------------------------------------------------------------------
switch whatIsBetter
case 'high'
    % Bigger numbers indicate better features:
    [testStat_sort,ifeat] = sort(testStat,'descend');
case 'abs'
    % Bigger magnitudes indicate better features:
    [~,ifeat] = sort(abs(testStat),'descend');
    testStat_sort = testStat(ifeat);
otherwise
    error('Unknown ''whatIsBetter'' option: %s',whatIsBetter)
end

isNaN = isnan(testStat_sort);
testStat_sort = testStat_sort(~isNaN);
ifeat = ifeat(~isNaN);

% List the top features:
for i = 1:numTopFeatures
    ind = ifeat(i);
    fprintf(1,'[%u] %s (%s) -- %4.2f%s\n',Operations.ID(ind),...
            Operations.Name{ind},Operations.Keywords{ind},...
            testStat_sort(i),statUnit);
end

%-------------------------------------------------------------------------------
%% Define the indices of features we will go on to visualize
% (and construct text labels for them)
%-------------------------------------------------------------------------------
featInd = ifeat(1:numTopFeatures);
makeLabelMinimal = @(x) sprintf('[%u] %s (%4.2f%s)',Operations.ID(x),Operations.Name{x},...
                        testStat(x),statUnit);
makeLabelFull = @(x) sprintf('[%u] %s (%s) (%4.2f%s)',Operations.ID(x),Operations.Name{x},...
                    Operations.Keywords{x}, testStat(x),statUnit);
topFeatureLabelsMinimal = arrayfun(@(x) makeLabelMinimal(x),featInd,'UniformOutput',false);
topFeatureLabelsFull = arrayfun(@(x) makeLabelFull(x),featInd,'UniformOutput',false);

%-------------------------------------------------------------------------------
%-------------------------------------------------------------------------------
%% Plot outputs
%-------------------------------------------------------------------------------
%-------------------------------------------------------------------------------

%-------------------------------------------------------------------------------
%% Histogram of distribution of test statistics for labeled and null data
%-------------------------------------------------------------------------------
if ismember('histogram',whatPlots)
    % Plot the distribution of test statistics across all features:

    %-------------------------------------------------------------------------------
    % Compute null distribution
    %-------------------------------------------------------------------------------
    testStat_rand = zeros(numFeatures,numNulls);
    if numNulls > 0
        fprintf(1,'Now for %u nulls... ',numNulls);
        tic
        for j = 1:numNulls
            if j < numNulls
                fprintf(1,'%u,',j);
            else
                fprintf(1,'%u.',j);
            end
            shuffledLabels = TimeSeries.Group(randperm(height(TimeSeries)));
            testStat_rand(:,j) = giveMeStats(TS_DataMat,shuffledLabels,false);
        end
        fprintf(1,'\n%u %s statistics computed in %s.\n',numFeatures*numNulls,...
                                        testStatText,BF_TheTime(toc(timer)));

        % Pool nulls to estimate p-values
        pooledNulls = testStat_rand(:);
        pVals = arrayfun(@(x) mean(testStat(x) < pooledNulls),1:length(testStat));
        % FDR-corrected q-values:
        FDR_qVals = mafdr(pVals,'BHFDR','true');
        fprintf(1,'Estimating FDR-corrected p-values across all features by pooling across %u nulls.\n',numNulls);
        fprintf(1,'(Given strong dependences across %u features, will produce conservative p-values)\n',numFeatures);

        % Give summary:
        sigThreshold = 0.05;
        if any(FDR_qVals < sigThreshold)
            fprintf(1,['%u/%u features show better performance using %s than the null distribution\n' ...
                        'at the magical 0.05 threshold (FDR corrected).\n'],...
                            sum(FDR_qVals < 0.05),length(FDR_qVals),testStatText);
        else
            fprintf(1,['Tough day at the office, hey? No features show statistically better performance than ' ...
                    'the null distribution at a FDR of 0.05.\nDon''t you go p-hacking now, will you?\n']);
        end
    end

    %---------------------------------------------------------------------------
    % Plot histogram
    %---------------------------------------------------------------------------
    f = figure('color','w'); hold('on')
    f.Position(3:4) = [559,278];
    colors = BF_GetColorMap('spectral',5,1);
    if numNulls == 0
        % Just plot the real distribution of test statistics across all features
        h_real = histogram(testStat,'Normalization','probability',...
                    'BinMethod','auto','FaceColor',colors{4},'EdgeColor','k');
        maxH = max(h_real.Values);
    else
        % Plot both real distribution and null distribution:
        numBins = 20;
        allTestStat = [testStat(:); testStat_rand(:)];
        minMax = [min(allTestStat),max(allTestStat)];
        histEdges = linspace(minMax(1),minMax(2),numBins+1);
        h_null = histogram(testStat_rand(:),histEdges,'Normalization','probability','FaceColor',colors{1});
        h_real = histogram(testStat,histEdges,'Normalization','probability',...
                                'FaceColor',colors{5},'EdgeColor','k');
        maxH = max([max(h_real.Values),max(h_null.Values)]);
        l_meannull = plot(nanmean(testStat_rand(:))*ones(2,1),[0,maxH],'--','color',colors{1},'LineWidth',2);
    end

    % Add chance line:
    if ~isnan(chanceLevel)
        l_chance = plot(chanceLevel*ones(2,1),[0,maxH],'--','color',colors{1},'LineWidth',2);
    end

    % Add mean of real distribution:
    l_mean = plot(nanmean(testStat)*ones(2,1),[0,maxH],'--','color',colors{5},'LineWidth',2);

    % Labels:
    xlabel(sprintf('Individual %s %s across %u features',testStatText,statUnit,numFeatures))
    ylabel('Probability')

    % Legend:
    if numNulls > 0
        if ~isnan(chanceLevel)
            legend([h_null,h_real,l_chance,l_meannull,l_mean],'null','real','chance','null mean','mean')
        else
            legend([h_null,h_real,l_meannull,l_mean],'null','real','null mean','mean')
        end
        title(sprintf(['%u features significantly informative of groups',...
                        ' (FDR-corrected at 0.05)'],sum(FDR_qVals < 0.05)))
    else
        if ~isnan(chanceLevel)
            legend([h_real,l_chance,l_mean],{'real','chance','mean'});
        else
            legend([h_real,l_mean],{'real','mean'});
        end
    end
else
    testStat_rand = [];
end

%-------------------------------------------------------------------------------
%% Distributions across classes for top features
%-------------------------------------------------------------------------------
if ismember('distributions',whatPlots)
    subPerFig = 16; % subplots per figure

    % Space the figures out properly:
    numFigs = ceil(numFeaturesDistr/subPerFig);

    % Make data structure for TS_SingleFeature
    data = struct('TS_DataMat',TS_DataMat,'TimeSeries',TimeSeries,...
                'Operations',Operations);

    for figi = 1:numFigs
        if figi*subPerFig > length(ifeat)
            break % We've exceeded number of features
        end
        % Get the indices of features to plot
        r = ((figi-1)*subPerFig+1:figi*subPerFig);
        if figi==numFigs % filter down for last one
            r = r(r <= numFeaturesDistr);
        end
        featHere = ifeat(r); % features to plot on this figure
        % Make the figure
        f = figure('color','w');
        f.Position(3:4) = [1353, 857];
        % Loop through features
        for opi = 1:length(featHere)
            subplot(ceil(length(featHere)/4),4,opi);
            TS_SingleFeature(data,Operations.ID(featHere(opi)),true,false,...
                                                testStat(featHere(opi)),false);
        end
    end
end

%-------------------------------------------------------------------------------
%% Data matrix containing top features
%-------------------------------------------------------------------------------
if ismember('datamatrix',whatPlots)
    ixFeat = BF_ClusterReorder(TS_DataMat(:,featInd)','corr','average');
    dataLocal = struct('TS_DataMat',BF_NormalizeMatrix(TS_DataMat(:,featInd(ixFeat)),'maxmin'),...
                    'TimeSeries',TimeSeries,...
                    'Operations',Operations(featInd(ixFeat),:));
    TS_PlotDataMatrix(dataLocal,'colorGroups',true,'groupReorder',true);
end

%-------------------------------------------------------------------------------
%% Pre-computing pairwise dependencies
% (for annotated dendrogram or feature–feature 'cluster' plot)
%-------------------------------------------------------------------------------
if ismember('dendrogram',whatPlots) || ismember('cluster',whatPlots)
    % 1. Compute pairwise Spearman correlations between all pairs of top features

    % (If it exists already, use that; otherwise compute it on the fly)
    % clustStruct = TS_GetFromData(whatData,'op_clust');
    % if isempty(clustStruct) % doesn't exist
    %     clustStruct = struct();
    % end
    % if isfield(clustStruct,'Dij') && ~isempty(clustStruct.Dij)
    %     % pairwise distances already computed, stored in the HCTSA .mat file
    %     fprintf(1,'Loaded %s distances from %s\n',clustStruct.distanceMetric,whatDataFile);
    %     Dij = squareform(clustStruct.Dij);
    %     Dij = Dij(featInd,featInd);
    %     distanceMetric = clustStruct.distanceMetric;
    % else
    %     % Compute correlations on the fly
    %     Dij = BF_pdist(TS_DataMat(:,featInd)','abscorr');
    %     distanceMetric = 'abscorr';
    % end

    % spearmanCorrs = corr(TS_DataMat(:,featInd)','abscorr');
    distanceMetric = 'abscorr'; % absolute Spearman correlation distances
    Dij = BF_pdist(TS_DataMat(:,featInd)',distanceMetric);
end


%-------------------------------------------------------------------------------
%% Dendrogram
% An annotated dendrogram showing the similarity between the set of top features
% (like the feature–feature correlation matrix but without the matrix)
%-------------------------------------------------------------------------------
if ismember('dendrogram',whatPlots)
    colorThreshold = 0.25;
    doVertical = false;
    f = figure('color','w');

    if doVertical
        f.Position(3:4) = [950,750];
    else
        f.Position(3:4) = [750,950];
    end

    [distVec,links] = BF_DoLinkage(Dij,distanceMetric,'average');
    % Get the dendrogram reordering:
    ord = BF_LinkageOrdering(distVec,links);
    if doVertical
        h_dend = dendrogram(links,0,'Orientation','right','Reorder',ord,...
                    'ColorThreshold',colorThreshold);
    else
        h_dend = dendrogram(links,0,'Orientation','top','Reorder',ord,...
                    'ColorThreshold',colorThreshold);
    end

    % Thicken lines:
    set(h_dend,'LineWidth',2)

    % Fix colors:
    BF_RecolorDendrogram(h_dend);

    % Label:
    box('on')
    ax = gca();
    ax.TickLabelInterpreter = 'none';
    if doVertical
        ax.YDir = 'reverse'; % needs to be reversed to match the imagesc plot (if 'cluster' is selected)
        ax.YTick = 1:numTopFeatures;
        ax.YTickLabel = topFeatureLabelsFull(ord);
        xlabel(sprintf('%s distance',distanceMetric));
    else
        ax.XTick = 1:numTopFeatures;
        ax.XTickLabel = topFeatureLabelsFull(ord);
        ylabel(sprintf('%s distance',distanceMetric));
        ax.XTickLabelRotation = 40;
    end
end

%-------------------------------------------------------------------------------
%% Inter-dependence of top features
%-------------------------------------------------------------------------------
% Plot the pairwise feature–feature correlation matrix (using BF_ClusterDown)
if ismember('cluster',whatPlots)
    clusterThreshold = 0.25; % threshold at which split into clusters
    [~,cluster_Groupi] = BF_ClusterDown(Dij,'clusterThreshold',clusterThreshold,...
                        'whatDistance',distanceMetric,...
                        'objectLabels',topFeatureLabelsMinimal);
    title(sprintf('Dependencies between %u top features (organized into %u clusters)',...
                            numTopFeatures,length(cluster_Groupi)))
end

%-------------------------------------------------------------------------------
%% Save a classifier (for the single best feature) to file
%-------------------------------------------------------------------------------
featureClassifier = struct();
if isfield(cfnParams,'classifierFilename') && ~isempty(cfnParams.classifierFilename)
    theTopFeatureIndex = ifeat(1);
    topFeatureValues = TS_DataMat(:,theTopFeatureIndex);

    % Build in-sample classifier (no CV):
    numFoldsAbove = cfnParams.numFolds;
    cfnParams.numFolds = 0;

    % Train a classification model on the top feature:
    GiveMeCfn(XTrain,yTrain,XTest,yTest,cfnParams,beVerbose)
    [bestTestStat,bestMdl,whatTestStat] = GiveMeCfn(topFeatureValues,TimeSeries.Group,...
                                                    topFeatureValues,TimeSeries.Group,...
                                                    cfnParams);

    % Prepare the featureClassifier structure:
    featureClassifier.Operation.ID = Operations.ID(theTopFeatureIndex); % Sorted list of top operations
    featureClassifier.Operation.Name = Operations.Name{theTopFeatureIndex}; % Sorted list of top operations
    featureClassifier.Mdl = bestMdl; % sorted feature models
    if numFoldsAbove > 0
        % From sorted accuracy of models
        featureClassifier.CVAccuracy = testStat_sort(1);
    else
        % CV was never done
        featureClassifier.CVAccuracy = NaN;
    end
    featureClassifier.Accuracy = bestTestStat;
    featureClassifier.whatTestStat = whatTestStat;
    featureClassifier.normalizationInfo = TS_GetFromData(whatData,'normalizationInfo');
    classes = cfnParams.classLabels;

    % Save to file
    if exist(cfnParams.classifierFilename,'file')~=0
        save(cfnParams.classifierFilename,'featureClassifier','classes','-append');
        fprintf(1,'Appended individual-feature classifiers to %s\n',cfnParams.classifierFilename);
    else
        save(cfnParams.classifierFilename,'featureClassifier','classes','-v7.3');
        fprintf(1,'Saved individual-feature classifiers to %s\n',cfnParams.classifierFilename);
    end
end

%-------------------------------------------------------------------------------
% Don't display unused outputs to screen:
if nargout == 0
    clear('ifeat','testStat','testStat_rand','featureClassifier');
end

%-------------------------------------------------------------------------------
%-------------------------------------------------------------------------------
function [theStatistic,stats] = fn_uStat(d1,d2,doExact,doP,doSigned)
    % Return a statistic from a Mann-Whitney U-test
    if doExact
        % use the exact method (slower)
        [p,~,stats] = ranksum(d1,d2,'method','exact');
    else
        % use the approximate method (faster)
        [p,~,stats] = ranksum(d1,d2,'method','approx');
    end
    if doP
        % -log10(p) from a Mann-Whitney U-test
        theStatistic = -log10(p);
    else
        % ranksum test statistic from a Mann-Whitney U-test
        theStatistic = stats.ranksum;
    end
    if doSigned
        % Gives the statistic the sign of the z statistic
        % (tracks wether higher or lower in the class)
        theStatistic = sign(stats.zval)*theStatistic;
    end
    % theStatistic = sign(stats.ranksum)*(-log10(p)); % (signed p-value)
end
%-------------------------------------------------------------------------------
function [theStatistic,stats] = fn_tStat(d1,d2,doP)
    % Return a statistic from a 2-sample Welch's t-test
    [~,p,~,stats] = ttest2(d1,d2,'Vartype','unequal');
    if doP
        % -log10(p) from the 2-sample Welch's t-test
        theStatistic = -log10(p);
    else
        % t-statistic from the 2-sample Welch's t-test
        theStatistic = stats.tstat;
    end
end
%-------------------------------------------------------------------------------
function [testStat,Mdl] = giveMeStats(dataMatrix,groupLabels,beVerbose)
    % Return a test statistic for each feature:
    testStat = zeros(numFeatures,1);
    if nargout==2
        Mdl = cell(numFeatures,1);
    end

    if strcmp(whatTestStat,'svmBeta')
        % Fit a linear SVM (multivariate) and return feature weights:
        % Mdl = fitcsvm(dataMatrix,dataLabels,'KernelFunction','linear');
        Mdl = fitcsvm(dataMatrix,groupLabels,'KernelFunction','linear','Weights',InverseProbWeight(groupLabels));
        testStat = Mdl.Beta; % (code assumes bigger is better)
        testStat = testStat/max(abs(testStat)); % rescale by max-abs
    else
        loopTimer = tic;
        BF_ProgressBar('new')
        for k = 1:numFeatures
            try
                if nargout == 2
                    % This is slower for the fast-linear classifier (but returns a model)
                    [testStat(k),Mdl{k}] = fn_testStat(dataMatrix(:,k),groupLabels,dataMatrix(:,k),groupLabels);
                else
                    testStat(k) = fn_testStat(dataMatrix(:,k),groupLabels,dataMatrix(:,k),groupLabels);
                end
            catch
                warning('Error computing %s test statistic for feature %u.',whatTestStat,k);
            end
            BF_ProgressBar(k/numFeatures)
        end
        BF_ProgressBar('close')
    end
end
%-------------------------------------------------------------------------------

end
