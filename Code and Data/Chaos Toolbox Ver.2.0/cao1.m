%此代码源程序中无，来自chatGPT
%时间：20230802-17:54 运行此代码会报错 运行不足
function [E1, E2] = cao1(data, min_m, max_m, tau)
    N = length(data);
    E1 = zeros(1, max_m - min_m + 1);
    E2 = zeros(1, max_m - min_m + 1);
    
    for m = min_m:max_m
        Y = NaN(N-(m-1)*tau, m);
        
        for i = 1:N-(m-1)*tau
            Y(i, :) = data(i:tau:i+(m-1)*tau);
        end
        
        D = pdist(Y, 'euclidean', 'smallest');
        D = D(~isnan(D));
        E1(m - min_m + 1) = mean(D);
        E2(m - min_m + 1) = std(D);
    end
end
