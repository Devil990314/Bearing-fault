clc;clear;close all;
%0901修改
disp("------------分析信号选择------------");
disp("------------1.振动信号（b216）  2.电流信号（b216）  3.CWRU信号  4.Paderborn信号 5.2023电流信号------------");
i=input("------------请选择要分析的信号(1 or 2 or 3 or 4 or 5)： ");
[data,fs,fr,Fre_Bearing]=Choose_Signa(i);N=length(data);%加载数据
Plot_Timing_Chart(data,fs,i);%绘制时序，频谱，包络谱图形
Plot_Power_specture(data,fs,i);%绘制功率谱图