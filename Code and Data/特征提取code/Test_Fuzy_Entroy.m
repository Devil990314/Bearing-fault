%% 主函数调用模糊熵函数求时间序列的模糊熵值
%此程序计算测试信号在相空间重构及eemd情况下的模糊熵
clc;clear;close all;tic;
 
% 产生仿真信号
fs=100;   %数据采样率Hz
t=1:1/fs:4096*1/fs; %对数据进行采样
n = length(t);  %数据的采样数目
f1 =0.25; %信号的频率
f2=30;
x=2*sin(2*pi*f1*t+cos(2*pi*f2*t)); %产生原始信号
nt=0.2*randn(1,n);  %高斯白噪声生成
y=x+nt; %含噪信号
 
% EEMD分解
Nstd=0.2;
NE=20;
X=eemd(y,Nstd,NE);    % EEMD分解函数在本人的资源里可供下载
 
% 相空间重构:eDim为嵌入维数
% 当X具有多列和多行时，每列将被视为独立的时间序列,该算法对X的每一列假设相同的嵌入维度和时间延迟,并以标量返回ESTDIM和ESTLAG。
[~,~,eDim] = phaseSpaceReconstruction(X); %相空间重构后，eDim仍为2，所以可舍去此步骤。
 
% 求时间序列X的模糊熵，模糊熵的输入时间序列为行向量
X=X';   % 将信号y的各个分量转置
[m,n]=size(X);
r0=0.15;   % r为相似容限度
FuzEn=zeros(1,m);
for i=1:m
    r=r0*std(X(i,:));
       FuzEn(i) = FuzzyEntropy(X(i,:),eDim,r,2,1);
end
toc;