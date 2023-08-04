clc;clear;close all;tic;
%此程序计算电流信号在eemd分解后各个IMF的的模糊熵，并且使用相空间重构求解了嵌入维数
%导入数据 导出的数据为data (2)为导出的数据选择的是第二列
Load_B216_data(2);
data=data(1:8192)';
fs=input('请输入采样频率(只输入整数，如10k只输入10)：');%手动输入采样频率
fs=fs*1000;
% EEMD分解
Nstd=0.2;
NE=20;
y=Data_row_current(1:8192);
X=eemd(y,Nstd,NE);    % EEMD分解函数在本人的资源里可供下载
 
% 相空间重构:eDim为嵌入维数
% 当X具有多列和多行时，每列将被视为独立的时间序列,该算法对X的每一列假设相同的嵌入维度和时间延迟,并以标量返回ESTDIM和ESTLAG。
[~,~,eDim] = phaseSpaceReconstruction(X);
 
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