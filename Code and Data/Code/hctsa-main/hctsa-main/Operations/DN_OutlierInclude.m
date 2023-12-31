function out = DN_OutlierInclude(y,thresholdHow,inc)
% DN_OutlierInclude     How statistics depend on distributional outliers.
%
% Measures a range of different statistics about the time series as more and
% more outliers are included in the calculation according to a specified rule,
% of outliers being furthest from the mean, greatest positive, or negative
% deviations.
%
% The threshold for including time-series data points in the analysis increases
% from zero to the maximum deviation, in increments of 0.01*sigma (by default),
% where sigma is the standard deviation of the time series.
%
% At each threshold, the mean, standard error, proportion of time series points
% included, median, and standard deviation are calculated, and outputs from the
% algorithm measure how these statistical quantities change as more extreme
% points are included in the calculation.
%
%---INPUTS:
% y, the input time series (ideally z-scored)
%
% thresholdHow, the method of how to determine outliers:
%     (i) 'abs': outliers are furthest from the mean,
%     (ii) 'pos': outliers are the greatest positive deviations from the mean, or
%     (iii) 'neg': outliers are the greatest negative deviations from the mean.
%
% inc, the increment to move through (fraction of std if input time series is
%       z-scored)
%
% Most of the outputs measure either exponential [f(x) = Aexp(Bx)+C] or
% linear [f(x) = Ax + B] fits to the sequence of statistics obtained in
% this way.
%
% [future: could compare differences in outputs obtained with 'p', 'n', and
%               'abs' -- could give an idea as to asymmetries/nonstationarities??]

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

% ------------------------------------------------------------------------------
%% Preliminaries
% ------------------------------------------------------------------------------

% Check a Curve Fitting toolbox license is available
BF_CheckToolbox('curve_fitting_toolbox');

doPlot = false; % Plot some outputs

% ------------------------------------------------------------------------------
%% Check inputs and set defaults
% ------------------------------------------------------------------------------
% If the time series is a constant causes issues
if all(y == y(1))
    % This method is not suitable for such time series: return a NaN
    fprintf(1,'The time series is a constant!\n');
    out = NaN;
    return
end

% Check z-scored time series
if ~BF_iszscored(y)
    warning('The input time series should be z-scored')
end
N = length(y); % length of the time series

if nargin < 2 || isempty(thresholdHow)
    thresholdHow = 'abs'; % Analyze absolute value deviations in the time series by default
end

if nargin < 3
    inc = 0.01; % increment through z-scored time-series values
end

% ------------------------------------------------------------------------------
%% Initialize thresholds
% ------------------------------------------------------------------------------
% Could be better to just use a fixed number of increments here, from 0 to the max.
% (rather than forcing a fixed inc)
switch thresholdHow
    case 'abs' % analyze absolute value deviations
        thr = (0:inc:max(abs(y)));
        tot = N;
    case 'pos' % analyze only positive deviations
        thr = (0:inc:max(y));
        tot = sum(y >= 0);
    case 'neg' % analyze only negative deviations
        thr = (0:inc:max(-y));
        tot = sum(y <= 0);
otherwise
    error('Error thresholding with ''%s''. Must select either ''abs'', ''pos'', or ''neg''.',thresholdHow)
end

if isempty(thr)
    error('Error setting increments through the time-series values...')
end

%-------------------------------------------------------------------------------
% Calculate statistics of over-threshold events, looping over thresholds
%-------------------------------------------------------------------------------
msDt = zeros(length(thr),6); % mean, std, proportion_of_time_series_included,
                             % median of index relative to middle, mean,
                             % error
for i = 1:length(thr)
    th = thr(i); % the threshold

    % Construct a series consisting of inter-event intervals for parts
    % of the time series exceeding the threshold, th (in a given direction)

    switch thresholdHow
    case 'abs' % look at absolute value deviations
        r = find(abs(y) >= th);
    case 'pos' % look at only positive deviations
        r = find(y >= th);
    case 'neg' % look at only negative deviations
        r = find(y <= -th);
    end

    % The Dt (interval) time series of values exceeding threshold
    Dt_exc = diff(r);

    % ~~~~~~~~~~~~
    % Statistics on the interval time series:
    % ~~~~~~~~~~~~
    msDt(i,1) = mean(Dt_exc); % the mean value of inter-event intervals
    msDt(i,2) = std(Dt_exc)/sqrt(length(r)); % error on the mean
    msDt(i,3) = length(Dt_exc)/tot*100; % this is just really measuring the distribution
                                      % : the proportion of possible values
                                      % that are actually used in
                                      % calculation
    % ~~~~~~~~~~~~
    % Statistics on the indices of over-threshold events:
    % ~~~~~~~~~~~~
    % The [x/(N/2)-1] rescales such that the middle index, N/2 => 0, and N maps to 1, 0 maps to -1.
    msDt(i,4) = median(r)/(N/2)-1; % the median timing of events (relative to middle, N/2)
    msDt(i,5) = mean(r)/(N/2)-1; % mean timing of events (relative to middle, N/2)
    msDt(i,6) = std(r)/sqrt(length(r)); % variance of event timing
end

% ------------------------------------------------------------------------------
%% Trim
% ------------------------------------------------------------------------------
% NB: would be more efficient to catch this within the loop above

% Trim off where the number of events is only one; hence the differenced
% series returns NaN
fbi = find(isnan(msDt(:,1)),1,'first'); % first bad index
if ~isempty(fbi)
    msDt = msDt(1:fbi-1,:);
    thr = thr(1:fbi-1);
end

% Trim off where the statistic power is lacking: less than 2% of data
% included
trimthr = 2; % percent
mj = find(msDt(:,3) > trimthr,1,'last');
if ~isempty(mj)
    msDt = msDt(1:mj,:);
    thr = thr(1:mj);
end

% ------------------------------------------------------------------------------
%% Plot output
% ------------------------------------------------------------------------------
if doPlot
    figure('color','w');
    hold('on')
    plot(thr,msDt(:,1),'.-k');
    plot(thr,msDt(:,2),'.-b');
    plot(thr,msDt(:,3),'.-g');
    plot(thr,msDt(:,4)*100,'.-m');
    plot(thr,msDt(:,5)*100,'.-r');
    plot(thr,msDt(:,6),'.-c'); hold off
end

%-------------------------------------------------------------------------------
% Quantify outputs:
%-------------------------------------------------------------------------------

% ------------------------------------------------------------------------------
%% Fit an exponential to the mean inter-event interval as a function of the threshold
% ------------------------------------------------------------------------------
s = fitoptions('Method','NonlinearLeastSquares','StartPoint',[0.1 2.5 1]);
f = fittype('a*exp(b*x)+c','options',s);
emsg = '';
try
    [c,gof] = fit(thr',msDt(:,1),f);
catch emsg
    fprintf(1,'DN_OutlierInclude: error fitting exponential growth to means: %s\n',emsg);
end

if isempty(emsg)
    out.mfexpa = c.a;
    out.mfexpb = c.b;
    out.mfexpc = c.c;
    out.mfexpr2 = gof.rsquare;
    out.mfexpadjr2 = gof.adjrsquare;
    out.mfexprmse = gof.rmse;
else
    out.mfexpa = NaN;
    out.mfexpb = NaN;
    out.mfexpc = NaN;
    out.mfexpr2 = NaN;
    out.mfexpadjr2 = NaN;
    out.mfexprmse = NaN;
end

% ------------------------------------------------------------------------------
%% Fit an exponential to N: the valid proportion left in calculation
% ------------------------------------------------------------------------------
s = fitoptions('Method','NonlinearLeastSquares','StartPoint',[120,-1,-16]);
f = fittype('a*exp(b*x)+c','options',s);
[c,gof] = fit(thr',msDt(:,3),f);

out.nfexpa = c.a;
out.nfexpb = c.b;
out.nfexpc = c.c; % (is linearly anticorrelated with c.a)
out.nfexpr2 = gof.rsquare;
out.nfexpadjr2 = gof.adjrsquare;
out.nfexprmse = gof.rmse;

% ------------------------------------------------------------------------------
%% Fit an linear trend to N: the valid proportion left in calculation
% ------------------------------------------------------------------------------
s = fitoptions('Method','NonlinearLeastSquares','StartPoint',[-40,100]);
f = fittype('a*x+b','options',s);
[c,gof] = fit(thr',msDt(:,3),f);

out.nfla = c.a;
out.nflb = c.b;
out.nflr2 = gof.rsquare;
out.nfladjr2 = gof.adjrsquare;
out.nflrmse = gof.rmse;

% ------------------------------------------------------------------------------
%% Stationarity metrics
% ------------------------------------------------------------------------------
% Mean, median and std of the mean inter-event interval:
out.mdtm = mean(msDt(:,1));
out.mdtmd = median(msDt(:,1));
out.mdtstd = std(msDt(:,1));

% Mean, median and std of the median and mean of indices over-threshold events occur
out.mdrm = mean(msDt(:,4));
out.mdrmd = median(msDt(:,4));
out.mdrstd = std(msDt(:,4));

out.mrm = mean(msDt(:,5));
out.mrmd = median(msDt(:,5));
out.mrstd = std(msDt(:,5));

% ------------------------------------------------------------------------------
%% Cross correlation between mean and error
% ------------------------------------------------------------------------------
xc = xcorr(msDt(:,1),msDt(:,2),1,'coeff');
out.xcmerr1 = xc(end); % this is the cross-correlation at lag 1
out.xcmerrn1 = xc(1); % this is the cross-correlation at lag -1

% ------------------------------------------------------------------------------
%% Fit exponential to std in range
% ------------------------------------------------------------------------------
s = fitoptions('Method','NonlinearLeastSquares','StartPoint',[5, 1, 15]);
f = fittype('a*exp(b*x)+c','options',s);
emsg = [];
try
    [c,gof] = fit(thr',msDt(:,6),f);
catch emsg
    warning('Error fitting exponential growth to std: %s\n',emsg.message);
end

if isempty(emsg)
    out.stdrfexpa = c.a;
    out.stdrfexpb = c.b;
    out.stdrfexpc = c.c;
    out.stdrfexpr2 = gof.rsquare;
    out.stdrfexpadjr2 = gof.adjrsquare;
    out.stdrfexprmse = gof.rmse;
else
    out.stdrfexpa = NaN;
    out.stdrfexpb = NaN;
    out.stdrfexpc = NaN;
    out.stdrfexpr2 = NaN;
    out.stdrfexpadjr2 = NaN;
    out.stdrfexprmse = NaN;
end

% ------------------------------------------------------------------------------
%% Fit linear to errors in range
% ------------------------------------------------------------------------------
s = fitoptions('Method','NonlinearLeastSquares','StartPoint',[40, 4]);
f = fittype('a*x +b','options',s);
[c,gof] = fit(thr',msDt(:,6),f);

out.stdrfla = c.a;
out.stdrflb = c.b;
out.stdrflr2 = gof.rsquare;
out.stdrfladjr2 = gof.adjrsquare;
out.stdrflrmse = gof.rmse;

if doPlot
    figure('color','w')
    errorbar(thr,msDt(:,1),msDt(:,2),'k');
end

end
