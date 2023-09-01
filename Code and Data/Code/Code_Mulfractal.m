clc;clear;close all;
%0901修改
disp("------------分析信号选择------------");
disp("------------1.振动信号（b216）  2.电流信号（b216）  3.CWRU信号  4.Paderborn信号 5.2023电流信号------------");
i=input("------------请选择要分析的信号(1 or 2 or 3 or 4 or 5)： ");
[data_load,Fs,fr,Fre_Bearing]=Choose_Signa(i);
sizex=size(data_load);
if sizex(:,2) == 1
    data=data_load;
end
if sizex(:,2) ~= 1
    disp("------------当前的信号维度为：" + num2str(sizex));
    chose_i = input("------------当前信号为矩阵形式，请选择要分析的列：");
    data=data_load(:,chose_i);
    N=length(data);%加载数据
end
fs=4096;
s = 1; % 时间段的长度（单位：秒）
T1 = fs / s;
start = 50;%%%加载数据的开始部分
finish = 60;%%%加载数据的结束部分
x_1 = data(start * fs + 1 : finish * fs, 1);

%基波滤除代码 begin
i1=input("------------是否进行基波滤除？ 1.滤除 2.不滤除: ");
switch i1
    case 1
        x_2 = Fun_3Sigma(x_1,Fs);%对信号进行3西格玛处理
        x_3 = Fun_process_signal_designfilt(x_1, Fs, 1000);%对信号进行滤除基波处理
        x = x_3 - min(x_3);%归0处理，保证所有数据都是正值
    case 2
        x = x_1 - min(x_1);%归0处理，保证所有数据都是正值
    otherwise
        disp("------------滤波选择输入错误！")
end
%基波滤除代码 end
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
