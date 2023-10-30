function [data_DE,fs,fr] = Fun_load_Xichu_data()
fs=12000;fr=0;
% 弹出打开文件对话框，以选取.mat文件
[fname, pname] = uigetfile('*.mat', '选择.mat文件');

% 如果用户取消了操作，则返回空值
if isequal(fname,0) || isequal(pname,0)
    data_DE = [];
    data_RPM = [];
    disp("用户取消了操作！")
    return;
end

% 拼接文件路径和文件名
filename = fullfile(pname, fname);

% 从文件中加载数据
load(filename);

% 获取所有变量名称
varNames = who;

% 确定包含 'DE' 和 'RPM' 的变量名称
DE_varName = "";
RPM_varName = "";
for ii = 1:length(varNames)
    if contains(varNames{ii}, "DE")
        DE_varName = varNames{ii};
    end
    if contains(varNames{ii}, "RPM")
        RPM_varName = varNames{ii};
    end
end

% 提取 'DE' 和 'RPM' 变量的值
if ~isempty(DE_varName)
    data_DE = eval(DE_varName);
else
    error("没有找到包含 DE 的变量");
end

if ~isempty(RPM_varName)
    data_RPM = eval(RPM_varName);
    fr=data_RPM;
else
    error("没有找到包含 RPM 的变量");
end
fprintf('------------数据路径: %s\n', filename);
%assignin('caller','fr',data_RPM);%将输出返回至主函数
end