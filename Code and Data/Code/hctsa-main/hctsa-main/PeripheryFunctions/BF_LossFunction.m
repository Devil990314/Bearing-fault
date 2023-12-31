function outputMeasure = BF_LossFunction(yTest,yPredict,whatLoss,classLabels)
% BF_LossFunction gives a measure of classification performance
%
% All labels are expected to be integers, ranging from 1 to the total number
% of classes in the classification problem
%
%---INPUTS:
% yTest, the test set labels
% yPredict, the predicted labels
% whatLoss, the loss function to use:
%               (*) 'acc': classification rate (%)
%               (*) 'balancedAcc': mean classification rate of each class (%,
%                                        same as acc when balanced classes)
%               (*) 'sumLoss': total number of misclassifications
% classLabels, labels for each class

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
% This function is free software: you can redistribute it and/or modify it under
% the terms of the GNU General Public License as published by the Free Software
% Foundation, either version 3 of the License, or (at your option) any later
% version.
%
% This program is distributed in the hope that it will be useful, but WITHOUT
% ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
% FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
% details.
%
% You should have received a copy of the GNU General Public License along with
% this program. If not, see <http://www.gnu.org/licenses/>.
% ------------------------------------------------------------------------------

%-------------------------------------------------------------------------------
%% Check Inputs
%-------------------------------------------------------------------------------
if nargin < 4
    classLabels = categories([yPredict;yTest]);
end

%-------------------------------------------------------------------------------
%% Set the loss/accuracy function:
%-------------------------------------------------------------------------------
switch whatLoss
case {'acc','accuracy','Accuracy'}
    % Overall classification rate:
    outputMeasure = 100*mean(yTest==yPredict);
case {'balancedAcc','balancedAccuracy'}
    outputMeasure = 100*mean(arrayfun(@(x) mean(yPredict(yTest==x)==yTest(yTest==x)),classLabels));
case 'sumLoss'
    % Sum of errors:
    outputMeasure = sum(yTest~=yPredict);
case 'balancedLoss'
    % Weighted sum of errors:
    classTotals = arrayfun(@(x)sum(yTest==x),classLabels);
    classWeights = zeros(length(yTest),1);
    for i = 1:length(yTest)
        classWeights(i) = 1/classTotals(yTest(i));
    end
    outputMeasure = sum((yTest~=yPredict).*classWeights);
otherwise
    error('Unknown loss function ''%s''',whatLoss);
end

end
