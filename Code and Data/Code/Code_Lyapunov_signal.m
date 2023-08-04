% 步骤1：准备数据
clc;clear;close all;
disp("------------分析信号选择------------");
disp("------------1.振动信号（b216）  2.电流信号（b216）  3.CWRU信号  4.Paderborn信号 5.2023电流信号------------");
i_1=input("------------请选择要分析的信号(1 or 2 or 3 or 4 or 5)： ");
[x,fs,fr,Fre_Bearing]=Choose_Signa(i_1);N=length(x);%加载数据
%选择要分析的数据
sizex=size(x);
if sizex(:,2) ~= 1
    disp("------------当前的信号维度为：" + num2str(sizex));
    chose_i = input("------------当前信号为矩阵形式，请选择要分析的列：");
    x=x(:,chose_i);
end
signal=x(1:3000);
% 设置延迟时间和嵌入维度
% 示例信号
% t = 0:0.01:10;
% signal = sin(pi * t) + 100*cos(0.5 * pi * t);

% 设置参数
m = 3; % 建议值为2-4
tau = 5; % 建议值为1-10
N = length(signal);

% 通过嵌入定理创建相空间
X = zeros(m,N-m*tau);
for i = 1:m
    X(i,:) = signal((1:N-m*tau)+(i-1)*tau);
end

% 计算最大Lyapunov指数
d = zeros(N-m*tau,1);
for i = 1:N-m*tau
    for j = 1:N-m*tau
        d(i) = d(i) + norm(X(:,i)-X(:,j));
    end
end
d = d./(N-m*tau);
t = (1:N-m*tau)';
p = polyfit(t,log(d),1);
lambda = p(1);

% 输出结果
disp(['最大Lyapunov指数为：', num2str(lambda)])