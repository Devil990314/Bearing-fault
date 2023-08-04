clc;clear;close all;
 
fs=4000;   % 采样频率为4000Hz
t=(0:1/fs:(2-1/fs))';
N=length(t);
x1=0.25*cos(0.875*pi*50*t);
x2=0.3*sin(2*pi*50*t).*(1+1.5*sin(0.5*pi*40*t));
x3=0.15*exp(-15*t).*sin(200*pi*t);
x=x1+x2+x3;
nt=0.2*randn(N,1);
y=x+nt;
%% CEEMDAN分解
Nstd = 0.2;                % 高斯白噪声标准差，一般选择0-1
NR = 100;                  % 加入噪声的次数，一般选择50-100
MaxIter = 500;            % 最大迭代次数
[imf, its]=ceemdan(y,Nstd,NR,MaxIter);
[m, n]=size(imf);
CC=zeros(1,m);  % 相关系数
figure;
for i=1:m
    subplot(m/2,2,i);plot(imf(i,:));ylabel(['IMF',num2str(i)]);
    CC(i)=corr(imf(i,:)',y,'type','Pearson');   % 相关系数
end