function [ff, x_mag_N, x_magDB_N, power_spectrum] = Fun_FFT(x, fs, x_lim)
    % 绘制原始信号及频谱
    sizex = size(x);
    
    if sizex(2) ~= 1
        disp("------------当前的信号维度为：" + num2str(sizex));
        chose_i = input("------------当前信号为矩阵形式，请选择要分析的列：");
        x = x(:, chose_i);
    end
    
    N = length(x);
    t = (0:N-1) / fs;
    
    figure;
    
    % 时域图
    subplot(2, 2, 1);
    plot(t, x, 'r');
    xlabel('时间/s');
    ylabel('幅值/v');
    title('信号时域图');

    n = 0:N-1;
    f = n * fs / N;
    y = fft(x, N);
    mag = abs(y) * 2 / N;

    ff = f(1:fix(N/2))';

    % 频域图
    subplot(2, 2, 2);
    x_mag_N = mag(1:fix(N/2));
    plot(ff, x_mag_N);
    xlabel('频率f/Hz');
    ylabel('幅值');
    title('信号频域图');
    xlim([1, x_lim]);

    % 分贝单位频域图
    subplot(2, 2, 3);
    x_magDB_N = 20 * log10(x_mag_N) - max(20 * log10(x_mag_N));
    plot(ff, x_magDB_N);
    xlabel('频率f/Hz');
    ylabel('幅值/dB');
    title('信号频域图');
    xlim([1, x_lim]);

    % 功率谱图
    subplot(2, 2, 4);
    power_spectrum = (x_mag_N).^2 / N;
    plot(ff, power_spectrum);
    xlabel('频率f/Hz');
    ylabel('功率');
    title('功率谱图');
    xlim([1, x_lim]);

    sgtitle('信号时域与频域分析');
end
