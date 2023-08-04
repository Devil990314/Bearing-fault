function Mult_Entropy = Fun_multiscale_entropy(data, t, N, r)
% 计算多尺度熵（Multiscale Entropy）
% 输入参数:
%   - data: 待分析的时间序列数据，一个列向量或矩阵
%   - t: 尺度因子，用于将时间序列分成多个段
%   - N: 分段个数
%   - r: 阈值
% 输出参数:
%   - jieguo: 多尺度熵结果矩阵，每一行对应一个尺度的结果

% 获取时间序列的长度和维度
[num_points, num_dims] = size(data);

% 初始化结果矩阵
Mult_Entropy = zeros(num_dims, 1);

% 遍历每个维度的时间序列
for dim = 1:num_dims
    % 提取当前维度的时间序列
    x = data(:, dim);
    
    % 初始化变量
    k = 0;
    y = zeros(N, 1);
    num = zeros(N, 1);
    c = zeros(N, 1);
    
    % 计算每个时间段的平均值
    for i = 1:N
        for j = 1+(i-1)*t : i*t
            k = k + x(j);
        end
        y(i) = k / t;
        k = 0;
    end
    
    % 计算m=2和m=3的多尺度熵
    for m = 2:3
        ph = 0;
        d = zeros(N-m+1, N-m+1);
        
        % 计算时间序列段之间的最大差值
        for i = 1:N-m+1
            for j = 1:N-m+1
                if j ~= i
                    d(i, j) = max(abs(y(i:i+m-1) - y(j:j+m-1)));
                end
            end
        end
        
        % 统计满足条件的时间序列段个数
        for i = 1:N-m+1
            for j = 1:N-m+1
                if d(i, j) < r
                    num(i) = num(i) + 1;
                end
            end
            c(i) = num(i) / (N-m);
            ph = ph + c(i);
        end
        
        % 计算多尺度熵
        ph = ph / (N-m+1);
        MSEn = log(ph / (N-m+1));
        
        % 将结果存储在结果矩阵中
        Mult_Entropy(dim) = MSEn;
    end
end

end
