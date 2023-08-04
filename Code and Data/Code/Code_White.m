clc; clear; close all;
fs = 1000;
t = 0:0.001:10;
x = 5 + 7*cos(2*pi*15*t - 30*pi/180) + 3*cos(2*pi*40*t - 90*pi/180);
x = x + randn(size(t));     %添加噪声 

% 假设你的输入信号是x，采样频率为fs
% 调整下面的参数以满足你的需求
order = 10; % AR 模型的阶数
r = 0.99; % 白化滤波器的相关系数

% 计算信号的自相关函数
[Rxx, lag] = xcorr(x, 'coeff');

% 截取自相关函数的正半轴
Rxx = Rxx(lag >= 0);

% 估计 AR 模型参数
[a, ~, ~] = aryule(Rxx, order);

% 计算白化滤波器的系数
b = sqrt(1 - r^2);

% 使用白化滤波器处理输入信号
x_whitened = filter(b, a, x);

% 绘制原始信号和白化后的信号
t = (0:length(x)-1) * (1/fs); % 时间轴
figure;
subplot(3,1,1);
plot(t, x);
title('原始信号');
xlabel('时间 (秒)');
ylabel('幅度');
subplot(3,1,2);
plot(t, x_whitened);
title('白化后的信号');
xlabel('时间 (秒)');
ylabel('幅度');

% 进行频谱分析
N = length(x); % 信号长度
f = (0:N-1)*(fs/N); % 频率轴
X = fft(x); % 原始信号的频谱
X_whitened = fft(x_whitened); % 白化后信号的频谱

% 绘制频谱图
subplot(3,1,3);
plot(f, abs(X), 'b', 'LineWidth', 1.5);
hold on;
plot(f, abs(X_whitened), 'r', 'LineWidth', 1.5);
title('频谱对比');
xlabel('频率 (Hz)');
ylabel('幅度');
legend('原始信号', '白化后的信号');
grid on;

