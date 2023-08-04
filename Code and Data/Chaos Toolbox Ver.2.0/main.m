%% 数据读取
clc;clear;close all;
disp("------------分析信号选择------------");
disp("------------1.振动信号（b216）  2.电流信号（b216）  3.CWRU信号  4.Paderborn信号 5.2023电流信号------------");
i=input("------------请选择要分析的信号(1 or 2 or 3 or 4 or 5)： ");
[data_all,data,Fs,fr,Fre_Bearing]=Choose_Signa(i);%都取的数据命名为：data_load
%% -------------------------------------------
PreStep=input('请输入预测步数(默认为10步)=');
if isempty(PreStep)
    PreStep=10
else
   PreStep
end 
 max_m=input('请输入cao法和G_P法中max_m(默认为20)=');
if isempty(max_m)
    max_m=20
else
   max_m
end
 max_N=input('请输入小波分解层数(默认为3)=');
if isempty(max_N)
    max_N=3
else
   max_N
end

if max_N==0
    main_process(data,PreStep,max_m);
else
    disp('---------小波多层分解-----------------')
    [A,D]=wave(data,max_N);
    main_process(A,PreStep,max_m);
    for i=1:max_N
        main_process(D(i,:)',PreStep,max_m);
    end
end
    
    
    