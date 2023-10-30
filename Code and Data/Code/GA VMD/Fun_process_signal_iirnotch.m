function [filtered_signal] = Fun_process_signal_iirnotch(input_signal, fs, low_pass_cutoff)
%该函数设计的滤波器不如另一种滤波器灵活
% process_signal - 消除基频及倍频，进行低通滤波
% input_signal: 时域信号
% fs: 采样频率
% low_pass_cutoff: 低通滤波截止频率

N = length(input_signal);
f = (0:(N-1))*(fs/N); % 计算频率

% FFT分析
fft_signal = fft(input_signal);

% 寻找基频
[~, max_idx] = max(abs(fft_signal(2:end/2))); % 不包括直流分量
fundamental_freq = f(max_idx + 1); % 基频

% 消除基频及倍频
bw = 1; % 带宽
order = 6; % 滤波器阶数
max_harmonic = floor(fs / 2 / fundamental_freq) - 1; % 计算最大谐波数

for harmonic = 1:max_harmonic
    freq = harmonic * fundamental_freq;

    % 设计带阻滤波器
    [b, a] = iirnotch(freq / (fs / 2), bw / (fs / 2),  order);

    % 应用滤波器
    input_signal = filter(b, a, input_signal);
end

% 低通滤波
%[b, a] = butter(order, low_pass_cutoff / (fs / 2));
%filtered_signal = filter(b, a, input_signal);
filtered_signal = input_signal;
end