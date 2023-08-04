function [ff,xx,xScatter,yScatter] = BF_ViolinPlot(dataCell,addMeans,doveTail,makeFigure,extraParams)
% Plots a scatter of a set of distributions with data points offset randomly (jittered)
%
%---INPUTS:
% dataCell, a cell where each element is a vector of numbers specifying a distribution
% addMeans, a flag for whether to add a strip for the mean of each group
% doveTail, whether to show a kernel smoothed distributions
% makeFigure, a flag to specify whether to generate a new figure to plot into
% extraParams, a structure of additional custom parameters
%
%---EXAMPLE USAGE:
% dataCell = {randn(1000,1),randn(500,1)*2+1};
% BF_ViolinPlot(dataCell,true,true,true);

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

if nargin < 2 || isempty(addMeans)
    addMeans = true; % Add strip for mean of each group
end
if nargin < 3 || isempty(doveTail)
    doveTail = true; % Add kernel distribution
end
if nargin < 4 || isempty(makeFigure)
    makeFigure = true; % Generate a new figure
end
if nargin < 5 || isempty(extraParams)
    extraParams = struct;
end

% ------------------------------------------------------------------------------
% Set extra parameters

numGroups = length(dataCell);

% Custom marker for points within the distribution:
if ~isfield(extraParams,'customSpot')
    customSpot = '.';
else
    customSpot = extraParams.customSpot;
end

% Custom x-offset
if ~isfield(extraParams,'customOffset')
    customOffset = 0;
else
    customOffset = extraParams.customOffset;
end

% Custom offset range; width of each jitter:
% (proportion of each consecutive unit interval to use for the plot)
if ~isfield(extraParams,'offsetRange')
    offsetRange = 0.5;
else
    offsetRange = extraParams.offsetRange;
end

% Horizontal or vertical
if ~isfield(extraParams,'makeHorizontal')
    makeHorizontal = false;
else
    makeHorizontal = extraParams.makeHorizontal;
end

% Custom HitTest settings
if ~isfield(extraParams,'dontHitMe')
    dontHitMe = false;
else
    dontHitMe = extraParams.dontHitMe;
end

% Custom colormap
if ~isfield(extraParams,'theColors')
    if numGroups <= 3
        theColors = BF_GetColorMap('set1',numGroups,1);
    else
        theColors = BF_GetColorMap('accent',numGroups,1);
    end
    if length(theColors) < numGroups
        theColors = arrayfun(@(x) zeros(3,1),1:numGroups,'UniformOutput',false);
    end
else
    theColors = extraParams.theColors;
    % fprintf(1,'Using custom colors\n');
end

%-------------------------------------------------------------------------------
% Reset random number generator for reproducibility:
rng('default');

if makeFigure
    figure('color','w');
end
hold('on');
box('on');

% ------------------------------------------------------------------------------
% Add kernel distribution
% ------------------------------------------------------------------------------
if doveTail
    ff = cell(numGroups,1);
    xx = cell(numGroups,1);
    for i = 1:numGroups
        if isempty(dataCell{i}) || all(isnan(dataCell{i}))
            continue
        end
        if any(isnan(dataCell{i}))
            warning('NaNs in dataCell')
        end
        [f,x] = ksdensity(dataCell{i},'npoints',500);
        f = f/max(f);

        % Only keep range where data exists:
        minKeep = max([1,find(x >= min(dataCell{i}),1,'first')]);
        maxKeep = min([length(x),find(x >= max(dataCell{i}),1,'first')]);
        keepR = minKeep:maxKeep;
        x = x(keepR);
        f = f(keepR);
        if makeHorizontal
            plot(x,customOffset + i + f*offsetRange/2,'-','color',theColors{i},'LineWidth',2)
            plot(x,customOffset + i - f*offsetRange/2,'-','color',theColors{i},'LineWidth',2)

            % Plot top and bottom
            plot(min(x)*ones(2,1),customOffset + i + [-f(1),f(1)]*offsetRange/2,'-','color',theColors{i},'LineWidth',0.1)
            plot(max(x)*ones(2,1),customOffset + i + [-f(end),f(end)]*offsetRange/2,'-','color',theColors{i},'LineWidth',0.1)
        else
            plot(customOffset + i + f*offsetRange/2,x,'-','color',theColors{i},'LineWidth',2)
            plot(customOffset + i - f*offsetRange/2,x,'-','color',theColors{i},'LineWidth',2)

            % Plot top and bottom
            plot(customOffset + i + [-f(1),f(1)]*offsetRange/2,min(x)*ones(2,1),'-','color',theColors{i},'LineWidth',0.1)
            plot(customOffset + i + [-f(end),f(end)]*offsetRange/2,max(x)*ones(2,1),'-','color',theColors{i},'LineWidth',0.1)
        end

        % Keep for dovetailing the jittered scatter points:
        xx{i} = x;
        ff{i} = f;
    end
end

% ------------------------------------------------------------------------------
% Plot jittered scatter for each group
% ------------------------------------------------------------------------------
xScatter = cell(numGroups,1);
yScatter = cell(numGroups,1);
if ~isempty(customSpot)
    pHandles = cell(numGroups,1);
    for i = 1:numGroups
        if doveTail
            xRand = zeros(length(dataCell{i}),1);
            for j = 1:length(dataCell{i})
                try
                    xRand(j) = (rand(1)*offsetRange - offsetRange/2)*ff{i}(find(xx{i} >= dataCell{i}(j),1));
                end
            end
        else
            xRand = rand([length(dataCell{i}),1])*offsetRange - offsetRange/2;
        end
        if makeHorizontal
            xScatter{i} = dataCell{i};
            yScatter{i} = customOffset + i + xRand;
        else
            xScatter{i} = customOffset + i + xRand;
            yScatter{i} = dataCell{i};
        end
        pHandles{i} = plot(xScatter{i},yScatter{i},customSpot,'color',theColors{i});
    end
    if dontHitMe
        for i = 1:length(pHandles)
            pHandles{i}.HitTest = 'off';
        end
    end
end

% ------------------------------------------------------------------------------
% Add strips for means and stds:
% ------------------------------------------------------------------------------
brightenAmount = -0.5;
if any(cellfun(@(x)any(isnan(x)),dataCell)), warning('NaNs in data'); end
for i = 1:numGroups
    try
        brightColor = brighten(theColors{i},brightenAmount);
    catch
        brightColor = theColors{i};
    end

    if addMeans
        if makeHorizontal
            plot(nanmean(dataCell{i})*ones(2,1),[customOffset + i - offsetRange/2,customOffset + i + offsetRange/2],'-',...
                            'color',brightColor,'LineWidth',3)
        else
            plot([customOffset + i - offsetRange/2,customOffset + i + offsetRange/2],nanmean(dataCell{i})*ones(2,1),'-',...
                            'color',brightColor,'LineWidth',3)
        end
    end
end

end
