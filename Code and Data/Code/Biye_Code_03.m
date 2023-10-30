clc;clear;close all;
%% 1025创建
%用于对信号进行滤波及峭度计算
disp("------------分析信号选择------------");
disp("------------1.振动信号（b216）  2.电流信号（b216）  3.CWRU信号  4.Paderborn信号 5.2023电流信号------------");
i=input("------------请选择要分析的信号(1 or 2 or 3 or 4 or 5)： ");
[data_all,data_select,fs,fr,Fre_Bearing]=Fun_Choose_Signa(i);N=length(data_all);%加载数据
%filtered_signal = Fun_process_signal_zerophase(data_select, fs, 1000);
Data_samples=Fun_create_samples(data_all);%把定子电流按照8192个数据1个样本，每相100个，总共划分300个样本
kurtosis = zeros(size(Data_samples,2),1); % 初始化峭度向量
for i = 1:size(Data_samples,2)
    kurtosis(i) = moment(Data_samples(:,i),4)/moment(Data_samples(:,i),2)^2; % 计算第i个IMF的峭度
end
figure;plot(1:1:size(Data_samples,2),kurtosis);

data_Filter_Fun_wave_12= Fun_process_signal_designfilt(data_select, fs, 12,1000);%%dB=12
[ff12, x_mag_N12, x_magDB_N12, power_spectrum12] = Fun_FFT(data_Filter_Fun_wave_12, fs, 200);
kurtosis_data_12 = moment(data_Filter_Fun_wave_12,4)/moment(data_Filter_Fun_wave_12,2)^2; % 计算第i个IMF的峭度
disp("------------信号经滤波器滤波后峭度为："+num2str(kurtosis_data_12));

t=42:0.0001:50;t=t';
data2=data_Filter_Fun_wave_12(20000:end);
[ff2, x_mag_N2, x_magDB_N2, power_spectrum2] = Fun_FFT(data2, fs, 200);
kurtosis_data_2 = moment(data2,4)/moment(data2,2)^2; % 计算第i个IMF的峭度
disp("------------信号经滤波器滤波后峭度为："+num2str(kurtosis_data_2));
%% 对信号进行滤波
% samples = Fun_splitVectorIntoSamples(data_Filter_Fun_wave_12, 10000);
% kurtosis_data=zeros(size(samples,1),1);
% for i=1:size(samples,1)
%     kurtosis_data(i)= moment(samples(i,:),4)/moment(samples(i,:),2)^2; % 计算第i个IMF的峭度
% end
% data_Filter_Fun_wave_1= Fun_process_signal_designfilt(data_select, fs, 1,1000);%%dB=12
%[ff1, x_mag_N1, x_magDB_N1, power_spectrum1] = Fun_FFT(data_Filter_Fun_wave_1, fs, 500);
%kurtosis_data_1 = moment(data_Filter_Fun_wave_1,4)/moment(data_Filter_Fun_wave_1,2)^2; % 计算第i个IMF的峭度
%disp("------------信号经滤波器滤波后峭度为："+num2str(kurtosis_data_1));

