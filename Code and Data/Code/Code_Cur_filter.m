clc;clear;close all;
disp("------------分析信号选择------------");
disp("------------1.振动信号（b216）  2.电流信号（b216）  3.CWRU信号  4.Paderborn信号 5.2023电流信号------------");
i=input("------------请选择要分析的信号(1 or 2 or 3 or 4 or 5)： ");
[x,fs,fr,Fre_Bearing]=Choose_Signa(i);N=length(x);%加载数据
%选择要分析的数据
sizex=size(x);
if sizex(:,2) ~= 1
    disp("------------当前的信号维度为：" + num2str(sizex));
    chose_i = input("------------当前信号为矩阵形式，请选择要分析的列：");
    x=x(:,chose_i);
end
x1=extract_time_segment(x,10, 20,fs);
filtered_signal_1 = Fun_3Sigma(x1,fs);
filtered_signal_2 = Fun_process_signal_designfilt(filtered_signal_1, fs, 1000);

%filtered_signal_3 = Fun_process_signal_iirnotch(filtered_signal_1, fs, 1000);
% 计算均值和标准差
Fun_FFT(x1,fs,500);
Fun_FFT(filtered_signal_2,fs,500);
%Fun_FFT(filtered_signal_3,fs,500);
