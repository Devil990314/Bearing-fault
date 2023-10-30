function Samples = Fun_create_samples(data,sample_data_numbers,sample_numblers)
    if nargin < 2
        sample_data_numbers = 8192; % 默认样本数据量
        sample_numblers = 300;
    end
    % data: 输入的时域数据矩阵
    
    % 获取数据的列数（假设为6）
    num_columns = size(data, 2);
    
    % 初始化样本矩阵
    samples = zeros(sample_data_numbers,sample_numblers);
    
    % 将每列数据按顺序切分为样本并连接起来
    for col = 2:2:num_columns
        col_data = data(:, col);
        for i = 1:sample_numblers/3
            start_index = (i-1) * sample_data_numbers + 1;
            end_index = start_index + sample_data_numbers - 1;
            samples(:, (col/2-1)*100 + i) = col_data(start_index:end_index);
        end
    end
    
    % 将样本存储在工作区中
    %assignin('base', 'Samples', samples);
    
    % 返回样本
    Samples = samples;
end
