clc;clear;close all;
%1025修改
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
%% 对信号进行滤波
[ff,x_mag_N, x_magDB_N, power_spectrum] = Fun_FFT(data_select, fs, 500);
kurtosis0= moment(data_select,4)/moment(data_select,2)^2; % 计算第i个IMF的峭度

data_Filter_Fun_wave_02 = Fun_process_signal_designfilt(data_select, fs, 0.2,1000);%%dB=0.2
[ff02,x_mag_N02, x_magDB_N02, power_spectrum02] = Fun_FFT(data_Filter_Fun_wave_02, fs, 500);
kurtosis02= moment(data_Filter_Fun_wave_02,4)/moment(data_Filter_Fun_wave_02,2)^2; % 计算第i个IMF的峭度

data_Filter_Fun_wave_1= Fun_process_signal_designfilt(data_select, fs, 1,1000);%%dB=1
[ff1, x_mag_N1, x_magDB_N1, power_spectrum1] = Fun_FFT(data_Filter_Fun_wave_1, fs, 500);
kurtosis1= moment(data_Filter_Fun_wave_1,4)/moment(data_Filter_Fun_wave_1,2)^2; % 计算第i个IMF的峭度

data_Filter_Fun_wave_2= Fun_process_signal_designfilt(data_select, fs, 2,1000);%%dB=2
[ff2, x_mag_N2, x_magDB_N2, power_spectrum2] = Fun_FFT(data_Filter_Fun_wave_2, fs, 500);
kurtosis2= moment(data_Filter_Fun_wave_2,4)/moment(data_Filter_Fun_wave_2,2)^2; % 计算第i个IMF的峭度

data_Filter_Fun_wave_3= Fun_process_signal_designfilt(data_select, fs, 3,1000);%%dB=3
[ff3, x_mag_N3, x_magDB_N3, power_spectrum3] = Fun_FFT(data_Filter_Fun_wave_3, fs, 500);
kurtosis3= moment(data_Filter_Fun_wave_3,4)/moment(data_Filter_Fun_wave_3,2)^2; % 计算第i个IMF的峭度

data_Filter_Fun_wave_4= Fun_process_signal_designfilt(data_select, fs, 4,1000);%%dB=4
[ff4, x_mag_N4, x_magDB_N4, power_spectrum4] = Fun_FFT(data_Filter_Fun_wave_4, fs, 500);
kurtosis4= moment(data_Filter_Fun_wave_4,4)/moment(data_Filter_Fun_wave_4,2)^2; % 计算第i个IMF的峭度

data_Filter_Fun_wave_6= Fun_process_signal_designfilt(data_select, fs, 6,1000);%%dB=6
[ff6, x_mag_N6, x_magDB_N6, power_spectrum6] = Fun_FFT(data_Filter_Fun_wave_6, fs, 500);
kurtosis6= moment(data_Filter_Fun_wave_6,4)/moment(data_Filter_Fun_wave_6,2)^2; % 计算第i个IMF的峭度

data_Filter_Fun_wave_10= Fun_process_signal_designfilt(data_select, fs, 10,1000);%%dB=10
[ff10, x_mag_N10, x_magDB_N10, power_spectrum10] = Fun_FFT(data_Filter_Fun_wave_10, fs, 500);
kurtosis10= moment(data_Filter_Fun_wave_10,4)/moment(data_Filter_Fun_wave_10,2)^2; % 计算第i个IMF的峭度

data_Filter_Fun_wave_12= Fun_process_signal_designfilt(data_select, fs, 12,1000);%%dB=12
[ff12, x_mag_N12, x_magDB_N12, power_spectrum12] = Fun_FFT(data_Filter_Fun_wave_12, fs, 500);
kurtosis12= moment(data_Filter_Fun_wave_12,4)/moment(data_Filter_Fun_wave_12,2)^2; % 计算第i个IMF的峭度

data_Filter_Fun_wave_12_new = Fun_process_signal_designfilt_new(data_select, fs, 12, 1000);
[ff122, x_mag_N122, x_magDB_N122, power_spectrum122] = Fun_FFT(data_Filter_Fun_wave_12_new, fs, 500);
kurtosis12_new= moment(data_Filter_Fun_wave_12_new,4)/moment(data_Filter_Fun_wave_12_new,2)^2; % 计算第i个IMF的峭度
%% 
kurtosisii = zeros(8,2); % 初始化峭度向量
figure;
plot(kurtosisii(:,1),kurtosisii(:,2), 'o-', 'LineWidth', 2, 'MarkerSize', 8);
xlabel('滤波器带宽/dB');
ylabel('峭度');
title("不同带宽时信号峭度值");
% 在图中标注每个数据点的x坐标和y坐标
for i = 1:size(kurtosisii, 1)
    text(kurtosisii(i,1), kurtosisii(i,2), num2str(kurtosisii(i,2)), 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom');
    text(kurtosisii(i,1), kurtosisii(i,2), num2str(kurtosisii(i,1)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top');
end
% 设置图形样式
grid on;
set(gca, 'FontSize', 12);
set(gca, 'FontWeight', 'bold');
set(gca, 'LineWidth', 1.5);
