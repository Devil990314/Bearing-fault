clc;clear;close all;
%此程序用于计算电流信号的各个熵值 2023.3.14
%导入数据 导出的数据为data (2)为导出的数据选择的是第二列
Load_B216_data(2);
data=data(1:8192)';
fs=input('请输入采样频率(只输入整数，如10k只输入10)：');%手动输入采样频率
fs=fs*1000;

%初始化熵值矩阵
Entroy_matrix=zeros(1,4);
%% 计算样本熵 √
tic;
dim=2;
r=0.2*std(data);
sampEn = SampleEntropy( dim, r, data);Entroy_matrix(1,1)=sampEn;
toc;
%% 计算排列熵 √
% 求排列熵:pe为排列熵
tic;
M = 5; T = 1;% 延迟时间1 % 嵌入维数 可以选择3-10，嵌入维数越大，时间越长
  
PeEn= PermutationEntropy(data,M,T);Entroy_matrix(1,2)=PeEn;
toc;
%% 计算模糊熵 
% 求时间序列X的模糊熵，模糊熵的输入时间序列为行向量
tic;eDim=2;r0=0.15*std(data);   % r为相似容限度
FuzEn = FuzzyEntropy(data,eDim,r0,2,1);Entroy_matrix(1,3)=FuzEn;toc;
%% 计算近似熵
tic;appen=approximateEntropy(data,1,2);Entroy_matrix(1,4)=appen;toc;
