
%% 信号读取
clc;clear;close all;
%0901修改
disp("------------分析信号选择------------");
disp("------------1.振动信号（b216）  2.电流信号（b216）  3.CWRU信号  4.Paderborn信号 5.2023电流信号------------");
i=input("------------请选择要分析的信号(1 or 2 or 3 or 4 or 5)： ");
[data_all,data_select,fs,fr,Fre_Bearing]=Fun_Choose_Signa(i);
%% 分形
data=data_select;
fs=4096;
s = 1; % 时间段的长度（单位：秒）
T1 = fs / s;
start = 50;%%%加载数据的开始部分
finish = 60;%%%加载数据的结束部分
x_1 = data(start * fs + 1 : finish * fs, 1);

x = x_1 - min(x_1);%归0处理，保证所有数据都是正值

n1 = 70;

amin1 = zeros(100, 1); % 记录每个时间段的最小alpha值
amax1 = zeros(100, 1); % 记录每个时间段的最大alpha值
da1 = zeros(100, 1); % 记录每个时间段的alpha变化范围
famin1 = zeros(100, 1); % 记录每个时间段的最小f_alpha值
famax1 = zeros(100, 1); % 记录每个时间段的最大f_alpha值
df1 = zeros(100, 1); % 记录每个时间段的f_alpha变化范围
for i = 1 : (finish - start) * s
    x1 = x((i - 1) * fs / s + 1 : i * fs / s); % 获取当前时间段的数据
    x2 = x1(1 : T1); % 取样本点数目 x2必须为2的n次幂

    % 计算分形参数
    [alpha1, f_alpha1] = mdfl1d(x2, [0 - n1 : 0.2 : n1]);

    % 记录分形参数和计算范围
    A1(:, i) = alpha1;
    f1(:, i) = f_alpha1;
    amin1(i) = alpha1(1);
    amax1(i) = alpha1(end);

    %amax1(i) = alpha1(10 * n1 + 1);
    da1(i) = amax1(i) - amin1(i);
    famin1(i) = f_alpha1(1);
    famax1(i) = f_alpha1(end);
    %famax1(i) = f_alpha1(10 * n1 + 1);
    df1(i) = famin1(i) - famax1(i);
    I(i) = sum(x2);
end
length_alpha=length(alpha1);
Mulfractal_result = zeros(length_alpha,20);b=1;
% 绘制所有时间段内的alpha和f_alpha的变化曲线
figure;
for i = 1 : (finish - start) * s
    Mulfractal_result(:,b)=A1(:,i);
    Mulfractal_result(:,b+1)=f1(:,i);
    plot(A1(:,i), f1(:,i));
    b=b+2;
    hold on;
end
grid on;
