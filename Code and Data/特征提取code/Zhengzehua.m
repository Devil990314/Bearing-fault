clc;clear all; close all;
% 选择要进行正则化的Excel文件
% 选择要进行正则化的Excel文件
[filename, filepath] = uigetfile('*.xlsx', 'Select the Excel file to be normalized');
if filename == 0
    disp('No file selected.');
    return;
end

% 读取所选Excel表格中的数据
data = readtable(fullfile(filepath, filename));

% 获取特征矩阵及标签
X = table2array(data(:, 2:end-1));
labels = table2cell(data(:, end));

% 对特征矩阵进行L1正则化
lambda = 1; % 设定正则化参数
n = size(X, 2); % 特征数量
w = zeros(n, 1); % 初始化权重向量
for i = 1:1000 % 迭代次数设为1000次
    for j = 1:n
        w_j = w;
        w_j(j) = 0;
        r_j = X * w_j - X * w + X(:, j); % 计算残差
        z_j = norm(X(:, j))^2; % 计算Z值
        if z_j == 0 % 避免除以0错误
            w(j) = 0;
        else
            w(j) = sign(sum(X(:, j)' * r_j)) * max(0, abs(sum(X(:, j)' * r_j)) - lambda) / z_j; % 更新权重
        end
    end
end

% 输出L1正则化后的特征矩阵
X_l1 = X * diag(w);

% 让用户选择输出文件位置和命名方式
[output_filename, output_filepath] = uiputfile('l1_normalized_*.xlsx', 'Save L1-normalized data as');
if output_filename == 0
    disp('No file selected.');
    return;
else
    output_fullpath = fullfile(output_filepath, output_filename);
end

% 将L1正则化后的特征矩阵存储到新的Excel表格
output_data = [num2cell((1:size(X_l1, 1))'), num2cell(X_l1), labels];
output_headers = {'Sample Index', data.Properties.VariableNames{2:end-1}, 'Label'};
output_table = cell2table(output_data, 'VariableNames', output_headers);
writetable(output_table, output_fullpath);

% 显示完成信息
disp(['L1 normalization completed. Normalized data saved to ', output_fullpath])
