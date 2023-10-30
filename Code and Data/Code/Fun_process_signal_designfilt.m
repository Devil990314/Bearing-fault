function filtered_signal = Fun_process_signal_designfilt(input_signal, fs, bw, low_pass_cutoff)
    % process_signal - 消除基频及倍频，进行低通滤波
    % input_signal: 时域信号
    % fs: 采样频率
    % bw: 滤波器带宽（可选，默认为3）
    % low_pass_cutoff: 低通滤波截止频率

    if nargin < 3
        bw = 3; % 默认带宽
        low_pass_cutoff = 500;
    end

    N = length(input_signal);
    f = (0:(N-1))*(fs/N); % 计算频率

    % 去除信号的直流分量
    input_signal = detrend(input_signal, 'constant');

    % FFT分析
    fft_signal = fft(input_signal,N);
    fft_abs_signal=abs(fft_signal);
    % 寻找基频
    [~, max_idx] = max(abs(fft_signal(2:end/2))); % 不包括直流分量
    fundamental_freq = f(max_idx+1); % 基频
    disp("------------当前信号基频为："+num2str(fundamental_freq)+"Hz");

    % 消除基频及倍频
    order = 6; % 滤波器阶数
    max_harmonic = floor(fs / 2 / fundamental_freq) - 1; % 计算最大谐波数
    filtered_signal = input_signal;
    disp("------------当前滤波器带宽为："+num2str(bw)+" dB");
    disp("------------当前滤波器阶数为："+num2str(order)+"阶");
    disp("------------当前滤波器截止频率为："+num2str(low_pass_cutoff)+" Hz");
    for harmonic = 1:max_harmonic
        freq = harmonic * fundamental_freq;

        % 设计带阻滤波器
        fstop = [freq-bw/2, freq+bw/2];
        d = designfilt('bandstopiir', 'FilterOrder', order, 'HalfPowerFrequency1', fstop(1), 'HalfPowerFrequency2', fstop(2), 'SampleRate', fs);

        % 应用滤波器
        filtered_signal = filtfilt(d, filtered_signal);
    end
    
    % 低通滤波
    [b, a] = butter(order, low_pass_cutoff / (fs / 2));
    filtered_signal = filtfilt(b, a, filtered_signal);
end
