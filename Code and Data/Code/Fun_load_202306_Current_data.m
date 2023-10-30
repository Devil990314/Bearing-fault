function [data,fs,fr] = Fun_load_202306_Current_data()
fs=10*1000;

% 打开文件选择窗口，选择要读取的txt文件
[file, path] = uigetfile('*.txt');
if file == 0
    return; % 如果用户没有选择文件就直接退出程序
end

% 读取txt文件中的数据
data = importdata(fullfile(path, file));
full_file_path = fullfile(path, file);
fprintf('------------数据路径: %s\n', full_file_path);
data=data.data;
fr=input("------------请输入转速/rpm：");
end