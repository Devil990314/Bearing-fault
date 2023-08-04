function [Normalized_table] = z_score_normalize(table)
% Z-score标准化函数
% 输入参数：
%   - table: 要进行标准化的table类型数据
% 输出参数：
%   - normalized_table: 标准化后的table类型数据

% 获取table的列数和行数
[~, num_cols] = size(table);

% 对第一列以外的每一列进行标准化
for i = 2:num_cols-1
    column = table{:,i};
    column_mean = mean(column);
    column_std = std(column);
    normalized_column = (column - column_mean) / column_std;
    table{:,i} = normalized_column;
end

% 返回标准化后的table
Normalized_table = table;

[filename, filepath] = uiputfile('*.xlsx', '选择要保存的文件');
% 如果用户没有选择文件，则退出
if isequal(filename,0) || isequal(filepath,0)
    disp('用户取消了操作');
else
    % 将表格写入选定的文件中
    fullpath = fullfile(filepath, filename);
    writetable(Normalized_table, fullpath, 'Sheet', 'Sheet1');
    disp(['成功将提取出的特征矩阵归一化并导出为表格,保存路径为：' fullpath]);
end
Nor_feature_matrix=table2array(Normalized_table);
assignin('caller','Nor_feature_matrix',Nor_feature_matrix);%将该函数输出的特征矩阵输出返回至主函数
end