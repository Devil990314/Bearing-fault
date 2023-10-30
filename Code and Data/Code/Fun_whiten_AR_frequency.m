function [data_whitened, whitening_filter] = Fun_whiten_frequency(data,fs,jj)
% 计算信号的频谱
spectrum = fft(data);

% 计算频谱的功率谱密度
psd = abs(spectrum).^2 / length(data);

% 计算白化滤波器系数
whitening_filter = 1 ./ sqrt(psd);

% 对频谱应用白化滤波器
whitened_spectrum = spectrum .* whitening_filter;

% 将白化后的频谱转换回时域
data_whitened = ifft(whitened_spectrum);
% 绘制图形
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
