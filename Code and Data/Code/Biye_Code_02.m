%% 信号读取不进行基波滤除
clc;clear;close all;
disp("------------分析信号选择------------");
disp("------------1.振动信号（b216）  2.电流信号（b216）  3.CWRU信号  4.Paderborn信号 5.2023电流信号------------");
i=input("------------请选择要分析的信号(1 or 2 or 3 or 4 or 5)： ");
[data_all,data_select,fs,fr,Fre_Bearing]=Fun_Choose_Signa(i);
%% 对信号进行EWT分解与重构，选择低频及非基波信号重构
params.log = 0; % 指示是否使用对数频谱 0或1，表示是否使用对数频谱
params.preproc = 'tophat'; % 预处理方法 可以是'none','plaw','poly','morpho,'tophat'之一。
params.method = 'locmaxmin'; % EWT方法 可以是'locmax','locmaxmin','locmaxminf','adaptive','adaptivereg','scalespace'之一。
params.reg = 'gaussian'; % 正则化方法 可以是'none','gaussian','average','closing'之一。
params.lengthFilter = 10; % 滤波器宽度
params.sigmaFilter = 1; % 滤波器标准差

params.N = 6; % 最大支持数

params.degree = 3; % 多项式拟合的阶数
params.completion = 1; % 是否尝试补充模式数 0或1，表示如果检测到的模式数量低于params.N，是否尝试完成模式的数量。
params.InitBounds = [0.1, 0.3, 0.5]; % 自适应方法的初始边界 初始边界的索引向量（用于自适应方法和自适应正则化方法）。
params.typeDetect = 'otsu'; % 尺度空间方法的边界检测类型 （仅适用于scalespace方法）用于阈值推断的类型，
% 可选值为'otsu','halfnormal','empiricallaw','mean','kmeans'之一。
params.globtrend='none'; %用于从信号中移除全局趋势 可选：'none','plaw','poly','morpho','tophat'
params.detect='locmaxmin'; %选择不同的边界检测方法，并从预处理后的信号中检测边界
%可选值有 'locmax','locmaxmin','locmaxminf','adaptivereg','adaptive','scalespace',
tic;
xx=data_select;
tic;
[ewt,mfb,boundaries]=EWT1D(xx,params);
toc;
figure;
num_rows = size(ewt, 1);
L=length(xx);
f_length=length(fs*(0:(L/2))/L);
FFt_result=zeros(f_length, 2*num_rows);
%Fs = 100000;  % 假设采样频率为1Hz，可根据实际情况修改
for i = 1:num_rows
    x = ewt{i};
    subplot(num_rows, 2, 2*i-1);

    N=length(x);t = 0:1/fs:(N-1)/fs;
    plot(t,x);
    xlabel('Time (s)');
    ylabel('Amplitude');

    subplot(num_rows, 2, 2*i);
    L = length(x);
    f = fs*(0:(L/2))/L;
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
%% 计算各个imf的相关系数与峭度
for i = 1:1:num_rows
    cc(i)=max(min(corrcoef(ewt{i},xx)));
 end
figure;
plot(cc,'-g<','LineWidth',1.5,'MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',5);
set(gca,'XGrid', 'on', 'YGrid', 'on');
%legend('CC'); 
xlabel('IMF');
ylabel('相关系数');
title('各个IMF的相关系数')

kurtosis = zeros(num_rows,1); % 初始化峭度向量
for i = 1:num_rows
    kurtosis(i) = moment(ewt{i},4)/moment(ewt{i},2)^2; % 计算第i个IMF的峭度
end
%kurtosis(end) = moment(residual,4)/moment(residual,2)^2; % 计算残差的峭度

% 绘制各个IMF的峭度折线图
figure;
plot(kurtosis,'-b<','LineWidth',1.5,'MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',5);
set(gca,'XGrid', 'on', 'YGrid', 'on');
%legend('峭度'); 
xlabel('IMF');
ylabel('峭度'); %Kurtosis Kurtosis of each IMF and residual
title("各个IMF的峭度");
% 找出峭度大于3的IMF索引
index = find(kurtosis(1:end) > 3 ); % 使用逻辑运算符&
% 对这些IMF进行相加，进行信号重构
kurtosis_x=zeros(N,1);
for i=1:length(index)
   kurtosis_x=kurtosis_x+ewt{i};
end
%绘制重构信号与原始信号
figure;
plot(t,xx);
%hold on 
figure;
plot(t,kurtosis_x,'r');
xlabel('t/s');ylabel('幅值');legend('原信号','基于峭度的重构信号'); 
[ff, x_mag_N, x_magDB_N, power_spectrum] = Fun_FFT(xx, fs, 500);
[ff, x_mag_N, x_magDB_N, power_spectrum] = Fun_FFT(kurtosis_x, fs, 500);
%% 对信号进行
data_Filter_Fun_wave_1 = Fun_process_signal_designfilt(kurtosis_x, fs, 1000);%对信号进行第1次滤除基波处理
data_Filter_Fun_wave_2 = Fun_process_signal_designfilt(data_Filter_Fun_wave_1, fs, 1000);%对信号进行滤除基波处理
data_Filter_Fun_wave_3 = Fun_process_signal_designfilt(data_Filter_Fun_wave_2, fs, 1000);%对信号进行滤除基波处理
figure;
plot(t,data_Filter_Fun_wave_3,'r');
[ff, x_mag_N, x_magDB_N, power_spectrum] = Fun_FFT(xx, fs, 500);
[ff, x_mag_N, x_magDB_N, power_spectrum] = Fun_FFT(kurtosis_x, fs, 500);
[ff, x_mag_N, x_magDB_N, power_spectrum] = Fun_FFT(data_Filter_Fun_wave_1, fs, 500);
[ff, x_mag_N, x_magDB_N, power_spectrum] = Fun_FFT(data_Filter_Fun_wave_2, fs, 500);
[ff, x_mag_N, x_magDB_N, power_spectrum] = Fun_FFT(data_Filter_Fun_wave_3, fs, 500);
