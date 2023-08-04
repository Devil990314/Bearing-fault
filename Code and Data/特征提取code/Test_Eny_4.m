clc;clear;close all;tic;
%此程序用于计算测试信号的各个熵值 2023.3.14 
% 产生仿真信号
fs=100;   %数据采样率Hz
t=1:1/fs:4096*1/fs; %对数据进行采样
n = length(t);  %数据的采样数目
f1 =0.25; %信号的频率
f2=0.005;
x=2*sin(2*pi*f1*t+cos(2*pi*f2*t)); %产生原始信号
nt=0.2*randn(1,n);  %高斯白噪声生成
y=x+nt; %含噪信号
data=y;

%初始化熵值矩阵
Entroy_matrix=zeros(1,3);
%% 近似熵计算 √
[Appen,yun]=getApEn(data);
%tic;approxEnt = approximateEntropy(data,[],2);toc;
tic;appen=approximateEntropy(data,1,2);toc;
%% 计算样本熵 √
tic;
dim=2;
r=0.2*std(data);
sampEn = SampleEntropy( dim, r, data);Entroy_matrix(1,1)=sampEn;
toc;
%% 计算排列熵 √
% 求排列熵:pe为排列熵
tic;
M = 5;  % 嵌入维数
T = 1;  % 延迟时间
PeEn= PermutationEntropy(data,M,T);Entroy_matrix(1,2)=PeEn;
toc;
%% 计算模糊熵 √
% 求时间序列X的模糊熵，模糊熵的输入时间序列为行向量
tic;
r0=0.15;   % r为相似容限度
eDim=2;
FuzEn = FuzzyEntropy(data,eDim,r,2,1);Entroy_matrix(1,3)=FuzEn;
toc;