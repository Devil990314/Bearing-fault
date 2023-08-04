function [apEn,phi] = getApEn(x,varargin)
%   getApEn estimates the approximate entropy of a univariate data sequence.
%
%   [apEn,phi] = getApEn(x)
%
%   Returns the approximate entropy estimates `apEn` and the log-average 
%   number of matched vectors `phi` for `m` = 2, estimated from the data 
%   sequence `x` using the default parameters:
%   embedding dimension = 2, time delay = 1,
%   radius distance threshold = 0.2*std(`x`), logarithm = natural
%
%   [apEn,phi] = getApEn(x,name,value,...)
%
%   Returns the approximate entropy estimates `apEn` and the log-average 
%   number of matched vectors `phi` of the data sequence `x`
%   for dimensions = `m` using the specified name/value pair arguments:
% 
%       `m`      - Embedding Dimension, a positive integer
%       `tau`    - Time Delay, a positive integer
%       `r`       - Radius Distance Threshold, a positive scalar  
%       `logx` - Logarithm base, a positive scalar  
%
%   See the [信息熵系列#1——ApEn近似熵及Matlab实现](`https://zhuanlan.zhihu.com/p/574732876`)
%   for more info on these permutation entropy variants.
%
%   See also:
%       getSampEn, getFuzzyEn, getPermEn
%   
%   References:
%       [1] Steven M. Pincus. Approximate Entropy as a Measure of System 
%           Complexity[J]. Proceedings of the National Academy of Sciences 
%           of the United States of America, 1991, 88(6):2297-2301. 
%           DOI: 10.1073/pnas.88.6.2297
%
%   If you have any questions, please contact
%       C.G. Huang via hcg.001@163.com or comment on 
%       [信息熵系列#1——ApEn近似熵及Matlab实现](`https://zhuanlan.zhihu.com/p/574732876`)


narginchk(1,9)
x = squeeze(x);
x = x(:);

% Parse inputs
p = inputParser;
chk1 = @(x) isnumeric(x) && isscalar(x) && (x > 0) && (mod(x,1)==0);
chk2 = @(x) isscalar(x) && (x > 0);
addRequired(p,'x',@(x) isnumeric(x) && isvector(x) && (length(x) > 10));
addParameter(p,'m',2,chk1);
addParameter(p,'tau',1,chk1);
addParameter(p,'r',.2*std(x,1),chk2);
addParameter(p,'logx',exp(1),chk2);
parse(p,x,varargin{:})
m = p.Results.m; tau = p.Results.tau; 
r = p.Results.r; logx = p.Results.logx; 

% Improved efficiency 
%   by changing the double-precision float  array to single-precision
method = 'single'; % 'single' or 'double'
switch method
    case 'single'
        x = single(x);
        r = single(r);
end


r = r*std(x);
phi = zeros(2,1,method);
lenx = length(x);
for p = 1:2

    % Generate short series matrix `dataMat`
    rows = m+p-1;
    cols = lenx-(rows-1)*tau;
    dataMat = zeros(rows,cols,method);
    if rows < cols
        for ii = 1:rows
            dataMat(ii,:) = x((ii-1)*tau+1:(ii-1)*tau+cols);
        end
    else
        for ii = 1:cols
            dataMat(:,ii) = x(ii:tau:ii+rows*tau-1);
        end
    end
    dataMat = dataMat(:,1:lenx-m*tau);

    % Counting similar patterns using distance calculation
    cols = lenx-m*tau;
    counter = zeros(cols,1,method);
    for irow = 1:cols
        tempMat = abs(dataMat-repmat(dataMat(:,irow),1,cols));
        boolMat = all(tempMat<=r,1);
        counter(irow) = mean(boolMat);
    end

    % Summing over the counts
    phi(p) = mean(log(counter))/log(logx);
end
apEn = phi(1) -phi(2);

end