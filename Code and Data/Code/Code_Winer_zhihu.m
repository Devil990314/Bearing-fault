clc;clear;close all;
% https://zhuanlan.zhihu.com/p/422532840 维纳滤波的matlab应用实例及预测问题（Levinson-Durbin迭代）
% Constants in simulation
N       = 1000;      % 模拟信号的长度
varu    = 1;         % 输入信号 u 的方差
varv    = 1000;      % 噪声信号 v 的方差
a       = 0.999;     % AR 模型的自回归系数

% Generate the noisy observed signal
u       = sqrt(varu)*randn(N,1);  % 生成均值为零、方差为 varu 的高斯白噪声输入信号 u
s       = 0;                     % 初始化 s 为均值为零的信号
for n = 2:N
    s(n,1) = a*s(n-1,1) + u(n);  % 生成 AR(1) 过程信号 s
end
v       = sqrt(varv)*randn(N,1); % 生成均值为零、方差为 varv 的高斯白噪声 v
x       = s + v;                 % 观测信号 x，由信号 s 和噪声 v 构成

% Step 1
M       = 100;       % 计算自相关矩阵的延迟步长 M
tau     = (0:(M-1))';    % 延迟步长向量

% Step 2
rvv     = zeros(M,1);     % 初始化噪声信号 v 的自相关估计向量 rvv
rvv(1)  = varv;           % 自相关函数为方差（Kronecker Delta 函数）

% Step 3
rss     = (a.^abs(tau))/(1-a^2)/5*varu;   % 计算输出信号 s 的自相关估计向量 rss

% Step 4
rxx     = rss + rvv;      % 计算观测信号 x 的自相关估计向量 rxx

% Step 5
Rxx     = toeplitz(rxx);  % 构建观测信号 x 的自相关矩阵 Rxx

% Step 6
rxs     = rss;            % 构建观测信号 x 和输出信号 s 的互相关估计向量 rxs

% Step 7
w       = inv(Rxx)*rxs;   % Wiener 滤波器的权重向量

% Step 8
for n = M:N
    y(n,1) = w'*flipud(x((n-M+1):n));    % 进行 Wiener 滤波得到输出信号 y
end

%% Plot result
plot(x)               % 绘制观测信号 x
grid, xlabel('time index n'), ylabel('Amplitude'), hold on
plot(y)               % 绘制输出信号 y
plot(s)               % 绘制原始信号 s
legend('x(n)','y(n)','s(n)')    % 添加图例
title('Wiener filtering')       % 添加标题，表示 Wiener 滤波器