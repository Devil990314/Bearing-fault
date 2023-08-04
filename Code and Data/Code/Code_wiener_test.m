% 生成两个稍有不同的信号
t = 0:0.01:10;
signal1 = sin(2*pi*0.5*t); % 第一个信号
signal2 = sin(2*pi*0.5*t)+0.1*sin(2*pi*0.5*t); % 第二个信号，相对于第一个信号相位差为pi/4

% 添加高斯白噪声到信号中
noise = 0.1*randn(size(t));
noisy_signal1 = signal1 + noise;
noisy_signal2 = signal2 + noise;

% 设计维纳滤波器
reference_signal = signal1;
filtered_signal1 = wiener2(noisy_signal1);
filtered_signal2 = wiener2(noisy_signal2, size(reference_signal));

% 计算两个信号之间的差异量
difference = filtered_signal2 - reference_signal;

% 绘制结果
figure;
subplot(3,1,1);
plot(t, signal1, 'b', 'LineWidth', 1.5);
hold on;
plot(t, signal2, 'r', 'LineWidth', 1.5);
title('原始信号');
legend('Signal 1', 'Signal 2');
subplot(3,1,2);
plot(t, noisy_signal1, 'b', 'LineWidth', 1.5);
hold on;
plot(t, noisy_signal2, 'r', 'LineWidth', 1.5);
title('添加噪声后的信号');
legend('Noisy Signal 1', 'Noisy Signal 2');
subplot(3,1,3);
plot(t, filtered_signal2, 'r', 'LineWidth', 1.5);
hold on;
plot(t, reference_signal, 'b--', 'LineWidth', 1.5);
title('应用维纳滤波器后的信号');
legend('Filtered Signal 2', 'Reference Signal');

figure;
plot(t, difference, 'LineWidth', 1.5);
title('两个信号之间的差异');
xlabel('时间');
ylabel('差异量');
