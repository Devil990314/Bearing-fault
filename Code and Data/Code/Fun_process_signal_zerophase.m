function filtered_signal = Fun_process_signal_zerophase(input_signal, fs, low_pass_cutoff)
% process_signal - 消除基频及倍频，进行零相位滤波
% input_signal: 时域信号
% fs: 采样频率
% low_pass_cutoff: 低通滤波截止频率

% 计算基频
N = length(input_signal);
f = (0:(N-1))*(fs/N);
fft_signal = fft(input_signal, N);
[~, max_idx] = max(abs(fft_signal(2:end/2)));
fundamental_freq = f(max_idx+1);

% 消除基频及倍频
bw = 0.2;
max_harmonic = floor(fs / 2 / fundamental_freq) - 1;
input_signal_1 = input_signal;
for harmonic = 1:max_harmonic
    freq = harmonic * fundamental_freq;
    fstop = [freq-bw/2, freq+bw/2];
    d = designfilt('bandstopiir', 'FilterOrder', 8, 'HalfPowerFrequency1', fstop(1), 'HalfPowerFrequency2', fstop(2), 'SampleRate', fs);
    input_signal_1 = filtfilt(d, input_signal_1);
end

% 低通滤波
[b, a] = butter(8, low_pass_cutoff / (fs / 2));
filtered_signal = filtfilt(b, a, input_signal_1);
end
