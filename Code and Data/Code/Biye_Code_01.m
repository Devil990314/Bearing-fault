%此代码用于进行信号基波滤除后的EWT分解
%% 信号读取
clc;clear;close all;
%0901修改
disp("------------分析信号选择------------");
disp("------------1.振动信号（b216）  2.电流信号（b216）  3.CWRU信号  4.Paderborn信号 5.2023电流信号------------");
i=input("------------请选择要分析的信号(1 or 2 or 3 or 4 or 5)： ");
[data_all,data_select,fs,fr,Fre_Bearing]=Choose_Signa(i);
N=length(data_select);%加载数据
tic;[teagerEnergy1, teagerSpectrum1]=Code_calculateTeagerEnergy(data_all, 10000);toc;



[A,f] = Code_DESA(data_select');
%data_3Sigma2 = Fun_3Sigma(data_All_positive,fs);
%[ff,data_FFT_whi_t,data_FFT_DB_whi_t,data_pow_spec_whi_t]=Fun_FFT(data_Filter_Fun_wave,fs,500);
%filtered_signal_1 = Fun_process_signal_designfilt(filtered_signal_1, fs, 1000);
%[~,~,~,~]=Fun_FFT(filtered_signal_1,fs,500);
%% 对信号进行EWT处理，消除基波及高频信号
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

xx=data_Filter_Fun_wave;

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
%% EWT分解后保留到的信号
data_EWT_i=ewt{3};% 取低频第3个
filtered_signal_ewt = Fun_process_signal_designfilt(data_EWT_i, fs, 1000);

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
xx=filtered_signal_ewt;
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
%% EWT test 
%params.SamplingRate = -1; %put -1 if you don't know the sampling rate
params.SamplingRate = fs; %put -1 if you don't know the sampling rate
channel = 50; %for EEG only

% Choose the wanted global trend removal (none,plaw,poly,morpho,tophat)
params.globtrend = 'none';
params.degree=6; % degree for the polynomial interpolation

% Choose the wanted regularization (none,gaussian,avaerage,closing)
params.reg = 'none';
params.lengthFilter = 10;
params.sigmaFilter = 1.5;

% Choose the wanted detection method (locmax,locmaxmin,ftc,
% adaptive,adaptivereg,scalespace)
params.detect = 'scalespace';
params.typeDetect='otsu'; %for scalespace:otsu,halfnormal,empiricallaw,mean,kmeans
params.N = 5; % maximum number of bands
params.completion = 0; % choose if you want to force to have params.N modes
                       % in case the algorithm found less ones (0 or 1)
%params.InitBounds = [4 8 13 30];
params.InitBounds = [2 25];

% Perform the detection on the log spectrum instead the spectrum
params.log=0;

% Choose the results you want to display (Show=1, Not Show=0)
Bound=1;   % Display the detected boundaries on the spectrum
Comp=1;    % Display the EWT components
Rec=1;     % Display the reconstructed signal
TFplane=0; % Display the time-frequency plane (by using the Hilbert 
           % transform). You can decrease the frequency resolution by
           % changing the subresf variable below.
Demd=1;    % Display the Hilbert-Huang transform (YOU NEED TO HAVE 
           % FLANDRIN'S EMD TOOLBOX)
           
subresf=1;

InitBounds = params.InitBounds;
[ewt,mfb,boundaries]=EWT1D(data_select,params);
%Show the results

if Bound==1 %Show the boundaries on the spectrum
    div=1;
    if (strcmp(params.detect,'adaptive')||strcmp(params.detect,'adaptivereg'))
        Show_EWT_Boundaries(abs(fft(f)),boundaries,div,params.SamplingRate,InitBounds);
    else
        Show_EWT_Boundaries(abs(fft(f)),boundaries,div,params.SamplingRate);
    end
end

if Comp==1 %Show the EWT components and the reconstructed signal
    if Rec==1
        %compute the reconstruction
        rec=iEWT1D(ewt,mfb);
        Show_EWT(ewt,f,rec);
    else
        Show_EWT(ewt);
    end    
end

if TFplane==1 %Show the time-frequency plane by using the Hilbert transform
    EWT_TF_Plan(ewt,boundaries,params.SamplingRate,f,[],[],subresf,[]);
end           

%% 对信号进行白化处理 包括时域上的白化以及频域上的白化  &&频域上计算速度较快
% % 定义参数结构体 
% params.fs = fs;params.plot = true;
% params.order = 10;params.r = 0.9;

tic;
[data_whitened_time, ~]= Fun_whiten_AR_time(data_3Sigma,fs);%对信号AR模型的时域白化
toc;
data_whitened_time_3Sigma = Fun_3Sigma(data_whitened_time,fs);

tic;
[data_whitened_time, ~]= Fun_whiten_AR_time_block(data_3Sigma,fs,20000);%对信号AR模型的时域白化
toc;

tic;
[data_whitened__fre, ~] = Fun_whiten_AR_frequency(data_3Sigma,fs);%对信号进行AR模型的频域白化
toc;
data_whitened_fre_3Sigma = Fun_3Sigma(data_whitened__fre,fs);
[ff,data_FFT_whi_t,data_FFT_DB_whi_t,data_pow_spec_whi_t]=Fun_FFT(data_whitened__fre,fs,500);
[ff,data_FFT_whi_t,data_FFT_DB_whi_t,data_pow_spec_whi_t]=Fun_FFT(data_whitened_fre_3Sigma,fs,500);
%% 对白化后的信号进行频谱分析，并提取频谱结果中一定范围内的前20个极大值
[ff,data_FFT_whi_t,data_FFT_DB_whi_t,data_pow_spec_whi_t]=Fun_FFT(data_whitened_time_3Sigma,fs,500);
%[ff,data_FFT_whi_f,data_FFT_DB_whi_f,data_pow_spec_whi_f]=Fun_FFT(data_whitened_fre_3Sigma,fs,500);

% [top_peaks_t,top_locs_t]=Fun_find_peaks(data_pow_spec_whi_t,20);
% [top_peaks_f,top_locs_f]=Fun_find_peaks(data_pow_spec_whi_t,20);
matrix = zeros(length(ff), 2);
matrix(:,1)=ff;matrix(:,2)=data_FFT_whi_t;
%[max_values, max_coords] = Fun_find_max(matrix, 0, 1000);
[max_values, max_coords] = Fun_find_max(matrix, 0, 500);