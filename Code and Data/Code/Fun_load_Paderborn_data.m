function [data,fs,fr] = Fun_load_Paderborn_data()
% 读取指定文件夹下某个.mat文件中名为"Y"的结构体字段中名为"Data"的子字段中的第2，3，7个数据
fr=0;fs=64*1000;
[filename, folder_path] = uigetfile('*.mat'); % 打开对话框选择单个.mat文件
if filename == 0 % 用户取消文件选择，则直接返回
    disp("未选择任何文件，程序运行结束，返回空向量");
    Cur_signal_1 = [];
    Cur_signal_2 = [];
    Vir_signal = [];
    data=[Cur_signal_1;Cur_signal_2;Vir_signal];
    return;
end

file_path = fullfile(folder_path, filename);
data1= load(file_path); % 加载.mat文件
fields = fieldnames(data1);
data2=fields{1};
data=data1.(data2);
assignin('caller','YY',data);%将输出返回至主函数
assignin('caller','filename',data2);%将输出返回至主函数
if isfield(data, 'Y') % 判断是否存在目标结构体字段
    Y = data.Y; % 获取目标结构体变量
    assignin('caller','Y',Y);%将输出返回至主函数
    if isfield(Y, 'Data') % 判断是否存在目标结构体子字段
        Cur_signal_1 = Y(2).Data;
        Cur_signal_2 = Y(3).Data;
        Vir_signal = Y(7).Data;
        data=[Cur_signal_1;Cur_signal_2;Vir_signal;];
        data=data';
    else
        disp("目标结构体子字段不存在，程序运行结束，返回空向量");
        Cur_signal_1 = [];
        Cur_signal_2 = [];
        Vir_signal = [];
        data=[Cur_signal_1;Cur_signal_2;Vir_signal];
        data=data';
    end
else
    disp("目标结构体字段不存在，程序运行结束，返回空向量");
    Cur_signal_1 = [];
    Cur_signal_2 = [];
    Vir_signal = [];
    data=[Cur_signal_1;Cur_signal_2;Vir_signal];
    data=data';
end
if contains(filename(1:3),'09')
    fr = 900;
elseif contains(filename(1:3),'15')
    fr = 1500;
else
    error('Invalid filename');
end
fprintf('------------数据路径: %s\n', file_path);
end
