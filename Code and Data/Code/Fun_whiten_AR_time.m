function [data_whitened, whitening_filter] = Fun_whiten_AR_time(data,fs)
% whiten 对信号进行白化处理
%
% 输入参数：
%   data: 输入信号数据
%
% 输出参数：
%   data_whitened: 白化后的信号数据
%   whitening_filter: 白化滤波器系数

% 计算信号的自相关函数
autocorr_data = xcorr(data, 'biased');

% 计算自相关函数的Toeplitz矩阵
R = toeplitz(autocorr_data(length(data):end));

% 计算最优的白化滤波器系数
whitening_filter = -R(2:end, 2:end) \ R(2:end, 1);

% 对信号进行白化
data_whitened = filter([1; whitening_filter], 1, data);

t = (0:length(data)-1) / fs;
figure;
subplot(2,1,1);
plot(t, data);
xlabel('Time (s)');
ylabel('Amplitude');
title('Original Signal');
subplot(2,1,2);
plot(t, data_whitened);
xlabel('Time (s)');
ylabel('Amplitude');
title('Whitened Signal');

end