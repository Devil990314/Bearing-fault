clc;clear all;close all;
disp('请选择要汇总的文件夹：');
% 选择要读取的文件夹
folder_path = uigetdir(); % 打开文件夹选择对话框
% 获取所有Excel文件的文件名
excel_files = dir(fullfile(folder_path, '*.xls*')); % 查找所有扩展名为xls或xlsx的文件
new_data = cell(0); % 创建空cell数组
% 逐个读取Excel文件并汇总数据
start_row = 1; % 记录当前需要写入的行数
for i = 1:length(excel_files)
    file_name = fullfile(folder_path, excel_files(i).name); % 文件路径和名称
    [~, sheet_name] = xlsfinfo(file_name); % 获取工作簿内工作表的名称
    [~,~,raw] = xlsread(file_name, sheet_name{1}); % 读取第一个工作表的数据
    
    % 拼接数据到新表格
    new_data = [new_data; raw];
       
    start_row = start_row + size(raw,1)+1; % 更新起始行数
end
% 创建一个新的Excel文件
disp('请选择文件的保存路径及文件名称：');
[new_file_name, new_folder_path] = uiputfile('new_data.xlsx', 'Save As'); % 打开保存对话框，选择要保存的文件夹和文件名
new_file_name = fullfile(new_folder_path, new_file_name); % 新文件路径和名称
new_sheet_name = 'Sheet1'; % 新表格的名称
writetable(cell2table(new_data), new_file_name, 'Sheet', new_sheet_name); % 写入空表格到新Excel文件
% 提示完成
msgbox('数据汇总完成！');