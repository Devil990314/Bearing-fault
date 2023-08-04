function Fun_FFT(x,fs,x_lim)
%绘制原始信号及频谱
sizex=size(x);
if sizex(:,2) ~= 1
    disp("------------当前的信号维度为：" + num2str(sizex));
    chose_i = input("------------当前信号为矩阵形式，请选择要分析的列：");
    x=x(:,chose_i);
end
N = length(x);
figure;
subplot(2, 2, 1);
t = 0:1/fs:(N-1)/fs;
plot(t, x, 'r');
xlabel('时间/s');
ylabel('幅值/v');
title('信号时域图');

n = 0:N-1;
f = n * fs / N;                          % 频谱图的频率序列
y = fft(x, N);                           % 对信号进行快速傅里叶变换
mag = abs(y) * 2 / N;                     % 求得傅里叶变换后的振幅

subplot(2, 2, 2);
plot(f(1:fix(N/2)), mag(1:fix(N/2)));
xlabel('频率f/Hz');
ylabel('幅值');
title('信号频域图');
xlim([1,x_lim]);

% subplot(2, 2, 3);
% plot(f(1:fix(N/2)), 20*log10(mag(1:fix(N/2))));  % 将振幅转换为分贝单位
% xlabel('频率f/Hz');
% ylabel('幅值/dB');
% title('信号频域图');
% xlim([1,x_lim]);
subplot(2, 2, 3);
plot(f(1:fix(N/2)), 20*log10(mag(1:fix(N/2)))-max(20*log10(mag(1:fix(N/2)))));  % 将振幅转换为分贝单位，并调整使最大处为0dB
xlabel('频率f/Hz');
ylabel('幅值/dB');
title('信号频域图');
xlim([1,x_lim]);

subplot(2, 2, 4);
power_spectrum = (mag(1:fix(N/2))).^2 / N;    % 功率谱
plot(f(1:fix(N/2)), power_spectrum);
xlabel('频率f/Hz');
ylabel('功率');
title('功率谱图');
xlim([1,x_lim]);

sgtitle('信号时域与频域分析');

end