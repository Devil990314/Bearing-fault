%此代码用于对信号进行EWT分解 0901最新修改
%% 数据读取
clc;clear;close all;
disp("------------分析信号选择------------");
disp("------------1.振动信号（b216）  2.电流信号（b216）  3.CWRU信号  4.Paderborn信号 5.2023电流信号------------");
i=input("------------请选择要分析的信号(1 or 2 or 3 or 4 or 5)： ");
[data_all,data,Fs,fr,Fre_Bearing]=Choose_Signa(i);%都取的数据命名为：data_load
%% EWT中参数定义
params.log = 0; % 指示是否使用对数频谱 0或1，表示是否使用对数频谱
params.preproc = 'tophat'; % 预处理方法 可以是'none','plaw','poly','morpho,'tophat'之一。
params.method = 'locmaxmin'; % EWT方法 可以是'locmax','locmaxmin','locmaxminf','adaptive','adaptivereg','scalespace'之一。
params.reg = 'gaussian'; % 正则化方法 可以是'none','gaussian','average','closing'之一。
params.lengthFilter = 10; % 滤波器宽度
params.sigmaFilter = 1; % 滤波器标准差

params.N = 5; % 最大支持数

params.degree = 3; % 多项式拟合的阶数
params.completion = 1; % 是否尝试补充模式数 0或1，表示如果检测到的模式数量低于params.N，是否尝试完成模式的数量。
params.InitBounds = [0.1, 0.3, 0.5]; % 自适应方法的初始边界 初始边界的索引向量（用于自适应方法和自适应正则化方法）。
params.typeDetect = 'otsu'; % 尺度空间方法的边界检测类型 （仅适用于scalespace方法）用于阈值推断的类型，
% 可选值为'otsu','halfnormal','empiricallaw','mean','kmeans'之一。
params.globtrend='none'; %用于从信号中移除全局趋势 可选：'none','plaw','poly','morpho','tophat'
params.detect='locmaxmin'; %选择不同的边界检测方法，并从预处理后的信号中检测边界
%可选值有 'locmax','locmaxmin','locmaxminf','adaptivereg','adaptive','scalespace',
%%
tic;
[ewt,mfb,boundaries]=EWT1D(data,params);
toc;
rec=iEWT1D(ewt,mfb);%This function performs the inverse 1D Empirical Wavelet Transform by using the dual formulation.
Show_EWT(ewt,data,rec);
%Hilb=EWT_InstantaneousComponents(ewt,boundaries);
%N=length(data);t = 0:1/Fs:(N-1)/Fs;n = 0:N-1;f = n * Fs / N;
%function tf=EWT_TF_Plan(ewt,boundaries,Fe,sig,rf,rt,resf,color)
%tf=EWT_TF_Plan(ewt,boundaries,Fs,data,1,1,10000,1);%函数说明在toolbox文档第17页 当数据为2s长度时，程序顺利运行，无报错-0802-17:55
figure;
num_rows = size(ewt, 1);
L=length(data);
f_length=length(Fs*(0:(L/2))/L);
FFt_result=zeros(f_length, 2*num_rows);
%Fs = 100000;  % 假设采样频率为1Hz，可根据实际情况修改
for i = 1:num_rows
    x = ewt{i};
    subplot(num_rows, 2, 2*i-1);

    N=length(x);t = 0:1/Fs:(N-1)/Fs;
    plot(t,x);
    xlabel('Time (s)');
    ylabel('Amplitude');

    subplot(num_rows, 2, 2*i);
    L = length(x);
    f = Fs*(0:(L/2))/L;
    Y = fft(x);
    P2 = abs(Y) * 2 / N;  
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);

    FFt_result(:,2*i-1)=f;
    FFt_result(:,2*i)=P1;

    plot(f, P1);
    %xlim([0 500]);
    title(['Signal ', num2str(i)]);
    xlabel('Frequency (Hz)');
    ylabel('Amplitude');
end