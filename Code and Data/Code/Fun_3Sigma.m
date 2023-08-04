function filtered_signal = Fun_3Sigma(signal,fs)
% 计算均值和标准差
mean_value = mean(signal);
std_value = std(signal);

% 计算异常值的上限和下限
lower_bound = mean_value - 3 * std_value;
upper_bound = mean_value + 3 * std_value;

% 去除异常点并用均值代替
filtered_signal = signal;
filtered_signal(filtered_signal < lower_bound | filtered_signal > upper_bound) = mean_value;
% 绘制滤波前后的信号频谱对比图
N=length(filtered_signal);
t=0:1/fs:(N-1)/fs;
figure;
plot(t, signal, 'r');
hold on;
plot(t, filtered_signal, 'b');

title('原始信号与3\sigma滤波后的信号对比');
xlabel('时间/s');
ylabel('幅值/v');

legend('原始信号', '3\sigma滤波后的信号');

grid on;    % 添加网格线
end
