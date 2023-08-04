%% 此程序用于基于峭度和相关系数的EMD模态分量的分解与重构
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
%N=2^nextpow2(N/2);x=x(1:N);x=x-mean(x);%计算最近的2的n次幂，方便FFT，并且消除直流分量
%% 绘制原始信号及频谱
figure;subplot(2,1,1);t=0:1/fs:(N-1)/fs;plot(t,x,'r');
xlabel('时间/s');ylabel('幅值/v');title('原始信号时域')     % 画出原信号的时频图
n=0:N-1;
f=n*fs/N;                      			   % 频谱图的频率序列
y=fft(x,N);                 			   % 对信号进行快速傅里叶变换
mag=abs(y)*2/N;                			   % 求得傅里叶变换后的振幅，与真实幅值相比需要做abs(y)*2/N的运算
subplot(2,1,2); plot(f(1:fix(N/2)),mag(1:fix(N/2))); 
xlim([1,500]);mag_1=mag(1:500);
xlabel('频率f/Hz');ylabel('幅值');title('原始信号频域')% 绘出Nyquist频率之前随频率变化的振幅
% hold on;
% for i=1:10
%    plot([Fre_Bearing*i Fre_Bearing*i],[max(mag_1) min(mag_1)],'r--'); 
% end

%% emd及画出EMD分解的IMF值的图像
[imf,residual,info] = emd(x,'Interpolation','pchip');%'Interpolation','pchip'表示使用三次样条插值法对IMF进行补全和降采样
figure;
for i= 1:size(imf,2)
    subplot(size(imf,2),2,2*i-1);plot(imf(:,i));
    subplot(size(imf,2),2,2*i);
    y1=fft(imf(:,i),N);  
    mag=abs(y1)*2/N;    
    f=n*fs/N;    
    plot(f(1:fix(N/2)),mag(1:fix(N/2)));xlim([0,500]); 
end

%% 计算各个imf的相关系数以重构信号
for i = 1:1:size(imf,2)
    cc(i)=max(min(corrcoef(imf(:,i),x)));
 end
figure;
plot(cc,'-g<','LineWidth',1.5,'MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',5);
set(gca,'XGrid', 'on', 'YGrid', 'on');
%legend('CC'); 
xlabel('IMF');
ylabel('相关系数');
title('各个IMF的相关系数')
% 计算每个IMF分量与原始信号的相关系数，选择相关系数大于cor_num 的IMF分量作为候选
% cor_num=input('------------请输入重构系数相关系数最低值（0.8 0.7 0.6 ...）： ');
% candidate = find(cc >= cor_num);
% corrcoef_x=zeros(N,1);

[~, candidate] = maxk(cc, 2);%如要选择其他的IMF个数，更改maxk中的第二个数字
disp(['------------正在进行重构信号的IMF选择，此处选择IMF为------------ ',num2str(candidate)]);
corrcoef_x=zeros(N,1);
for i=1:length(candidate)
    corrcoef_x=corrcoef_x+imf(:,candidate(i));
end
%绘制重构信号与原始信号
figure;
plot(t,x);
hold on 
plot(t,corrcoef_x,'r');
xlabel('t/s');ylabel('幅值');legend('原信号','基于相关系数的重构信号'); %title('原始信号与使用相关系数重构后信号')
%绘制使用相关系数重构信号的频谱
corrcoef_y=fft(corrcoef_x,N);                 			   % 对信号进行快速傅里叶变换
mag_corrcoef_y=abs(corrcoef_y)*2/N;                			   % 求得傅里叶变换后的振幅，与真实幅值相比需要做abs(y)*2/N的运算
figure; plot(f(1:fix(N/2)),mag_corrcoef_y(1:fix(N/2))); 
xlim([1,500]);
xlabel('频率f/Hz');ylabel('幅值');title('基于相关系数重构的信号频域')% 绘出Nyquist频率之前随频率变化的振幅
Plot_Timing_Chart(x,fs,i_1);%绘制时序，频谱，包络谱图形
Plot_Power_specture(x,fs,i_1);%绘制功率谱图
disp("------------相关系数分析代码运行完毕");
%% 对信号进行emd分解后进行峭度计算
% 计算各个IMF和残差的峭度
kurtosis = zeros(size(imf,2),1); % 初始化峭度向量
for i = 1:size(imf,2)
    kurtosis(i) = moment(imf(:,i),4)/moment(imf(:,i),2)^2; % 计算第i个IMF的峭度
end
%kurtosis(end) = moment(residual,4)/moment(residual,2)^2; % 计算残差的峭度

% 绘制各个IMF的峭度折线图
figure;
plot(kurtosis,'-b<','LineWidth',1.5,'MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',5);
set(gca,'XGrid', 'on', 'YGrid', 'on');
%legend('峭度'); 
xlabel('IMF');
ylabel('峭度'); %Kurtosis Kurtosis of each IMF and residual
title("各个IMF的峭度");
% 找出峭度大于3的IMF索引
index = find(kurtosis(1:end) > 3 ); % 使用逻辑运算符&
% 对这些IMF进行相加，进行信号重构
kurtosis_x=zeros(N,1);
for i=1:length(index)
   kurtosis_x=kurtosis_x+imf(:,index(i));
end
%绘制重构信号与原始信号
figure;
plot(t,x);
hold on 
plot(t,kurtosis_x,'r');
xlabel('t/s');ylabel('幅值');legend('原信号','基于峭度的重构信号'); 
%绘制使用峭度重构信号的频谱
kurtosis_y=fft( kurtosis_x,N);                 			   % 对信号进行快速傅里叶变换
mag_kurtosis_y=abs(kurtosis_y)*2/N;                			   % 求得傅里叶变换后的振幅，与真实幅值相比需要做abs(y)*2/N的运算
figure; plot(f(1:fix(N/2)),mag_kurtosis_y(1:fix(N/2))); 
xlim([1,500]);
xlabel('频率f/Hz');ylabel('幅值');title('基于峭度的重构信号频谱')% 绘出Nyquist频率之前随频率变化的振幅
Plot_Timing_Chart(x,fs,i_1);%绘制时序，频谱，包络谱图形
Plot_Power_specture(x,fs,i_1);%绘制功率谱图
disp("------------峭度分析代码运行完毕");
