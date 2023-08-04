% 180s~330s以1s为单位求多重分形参数的变化趋势（共150s)，fmax,fmin,amax,amin,da,df
clc
clear all

T=2048;%采样频率
s=1; %5
T1 = T/s;

x=xlsread('E:\Bearing Fault\Code and Data\0_Data_202303\电流信号 C1 (9)\60_OR(Fix)_40Hz_2401rpm_109K_1s_C1.xlsx');%电流数据
bear=x(:,2);
start=0;
finish = 10;
x=bear(start*T+1:finish*T,1); 

x=x-min(x);

n1=90;


amin1=zeros(100,1);% amin=zeros(75,1);
amax1=zeros(100,1);% amax=zeros(75,1);
da1=zeros(100,1);%da=zeros(75,1); 
famin1=zeros(100,1);% famin=zeros(75,1);
famax1=zeros(100,1);%famax=zeros(75,1); 
df1=zeros(100,1);%df=zeros(75,1);

for i=1:(finish - start)*s %for i=1:94 1=1:150，94*s-1 
    x1=x((i-1)*T/s+1:i*T/s);   %从0开始
    x2=x1(1:T1); %16384);%取单元点数目
  [alpha1,f_alpha1]=mdfl1d(x2,[0-n1:.2:n1]);%[-80:.2:+80]
  A1(:,i)=alpha1;
  f1(:,i)=f_alpha1;
  amin1(i)=alpha1(1);
  amax1(i)=alpha1(10*n1+1); %length(alpha1)
  da1(i)=amax1(i)-amin1(i);
  famin1(i)=f_alpha1(1);
  famax1(i)=f_alpha1(10*n1+1);
  df1(i)=famin1(i)-famax1(i);
  I(i)=sum(x2);
end
figure;
plot(alpha1,f_alpha1);
grid on;
