% 180s~330s以1s为单位求多重分形参数的变化趋势（共150s)，fmax,fmin,amax,amin,da,df
clc
clear all
%y=unifrnd(0,1,10,2);
%y1=normrnd(2,10,1,10);
%T=1024; %5120  T取0.1个周期，因此后续start和finish取100-200表示10-20秒

T=2048;%采样频率
%T=8192;%采样频率
s=1; %5
T1 = T/s;

%load('C:\Users\Administrator\Desktop\电机故障诊断数据文件\Bias10s.txt')
%load ('E:\10-11封校\10-11封校资料\paper\毕业设计\数据\对象\正常\ewt022'); 
%load('E:\10-11封校\10-11封校资料\paper\毕业设计\数据\对象\正常\J_022.mat');
%load('E:\10-11封校\10-11封校资料\paper\毕业设计\数据\对象\外圈\013ewt.mat');
%bear=K13(:,1);
%bear=J_022;
% bear=ewt{5,1}+ewt{2,1};
x=xlsread('E:\Bearing Fault\Code and Data\0_Data_202303\电流信号 C1 (9)\56_OR(Fix)_30Hz_1802rpm_109K_1s_C1.xlsx');%电流数据
bear=x(:,2);

%bear=Z;
start=0;
finish = 10;
x=bear(start*T+1:finish*T,1); 
%x=awgn(x,20,'measured');%加入高斯白噪声
x=x-min(x);
%x=x/100;
% y=unifrnd(0,1,20480*150,1);%产生随机噪声
%x=x+y/10;  %加入随机噪声
%t=1/5120;
% t1=(t:t:150);
% plot(t1,x);
% T=512;%T=20480*2
n1=10;  %q的范围 ；%(正常60，轴承故障) 100往下试
% n4=40;
% n2=70;
% n3=90;
% n5=50;
% n6=30;
% n7=50;

amin1=zeros(100,1);% amin=zeros(75,1);
amax1=zeros(100,1);% amax=zeros(75,1);
da1=zeros(100,1);%da=zeros(75,1); 
famin1=zeros(100,1);% famin=zeros(75,1);
famax1=zeros(100,1);%famax=zeros(75,1); 
df1=zeros(100,1);%df=zeros(75,1);

% for i=1:100
%     for j=1:401
%        Tq(j,i)=(-40+(j-1)*0.2)*A1(j,i)+f1(j,i);    
%     end
% end

for i=1:(finish - start)*s %for i=1:94 1=1:150，94*s-1 
    x1=x((i-1)*T/s+1:i*T/s);   %从0开始
    x2=x1(1:T1); %16384);%取单元点数目
    %x2=x2';
%   x2=x((i-1)*T/s+1:i*T/s); %16384);%取单元点数目
  %[alpha1,f_alpha1,zaq,a,tq,q]=mdfl1d(x2); 
  [alpha1,f_alpha1]=mdfl1d(x2,[0-n1:.2:n1]);%[-80:.2:+80]
  %  [alphat,f_alphat,zaqt,at,tqt,qt]=mdfl1d(x2,[-10:0.2:10]); %[-18:.2:+18]);%,[10 1 512],'linpart','pls');改变权重因子
 % Tq(:,i)=tq;
  A1(:,i)=alpha1;
  f1(:,i)=f_alpha1;
  amin1(i)=alpha1(1);
  amax1(i)=alpha1(10*n1+1); %length(alpha1)
  da1(i)=amax1(i)-amin1(i);
  famin1(i)=f_alpha1(1);
  famax1(i)=f_alpha1(10*n1+1);
  df1(i)=famin1(i)-famax1(i);
  I(i)=sum(x2);
%   I(i)=sum(x1);
end

% for i=1:(finish - start)*s-1
%    Z(i)= log(I(i+1)/I(i));
% end

% for i=96:104 %for i=1:94 1=1:150
%    x1=x((i-1)*T+1:i*T);
%    x2=x1(1:16384); %16384);%取单元点数目
% %   x2=x((i-1)*T/s+1:i*T/s); %16384);%取单元点数目
%   %[alpha1,f_alpha1,zaq,a,tq,q]=mdfl1d(x2); 
%   [alpha1,f_alpha1]=mdfl1d(x2,[0-n4:.2:n4]);%[-80:.2:+80]
%   %  [alphat,f_alphat,zaqt,at,tqt,qt]=mdfl1d(x2,[-10:0.2:10]); %[-18:.2:+18]);%,[10 1 512],'linpart','pls');改变权重因子
%  % Tq(:,i)=tq;
%   AB1(:,i)=alpha1;
%   fB1(:,i)=f_alpha1;
%   amin1(i)=alpha1(1)
%   amax1(i)=alpha1(10*n4+1);
%   da1(i)=amax1(i)-amin1(i);
%   famin1(i)=f_alpha1(1);
%   famax1(i)=f_alpha1(10*n4+1);
%   df1(i)=famin1(i)-famax1(i);
%   I(i)=sum(x2);
% %   I(i)=sum(x1);
% end
% for i=126:150 %for i=1:75 1=1:150
%   x1=x((i-1)*T+1:i*T);
% %    x1=x((i-1)*T+1:i*T);
%    x2=x1(1:16384); %16384);%取单元点数目
% %   x2=x((i-1)*T/s+1:i*T/s); %16384);%取单元点数目
%   %[alpha1,f_alpha1,zaq,a,tq,q]=mdfl1d(x2); 
%   [alpha1,f_alpha1]=mdfl1d(x2,[0-n2:.2:n2]);%[-80:.2:+80]
%   %  [alphat,f_alphat,zaqt,at,tqt,qt]=mdfl1d(x2,[-10:0.2:10]); %[-18:.2:+18]);%,[10 1 512],'linpart','pls');改变权重因子
%  % Tq(:,i)=tq;
%   A1(:,i)=alpha1;
%   f1(:,i)=f_alpha1;
%   amin1(i)=alpha1(1)
%   amax1(i)=alpha1(10*n2+1);
%   da1(i)=amax1(i)-amin1(i);
%   famin1(i)=f_alpha1(1);
%   famax1(i)=f_alpha1(10*n2+1);
%   df1(i)=famin1(i)-famax1(i);
%   I(i)=sum(x2);
% %   I(i)=sum(x1);
% end
% for i=104*s:150*s %for i=1:75 1=1:150
% %   x1=x((i-1)*T+1:i*T);
% %    x1=x((i-1)*T+1:i*T);
% %    x2=x1(1:16384); %16384);%取单元点数目
%   x2=x((i-1)*T/s+1:i*T/s); %16384);%取单元点数目
%   %[alpha1,f_alpha1,zaq,a,tq,q]=mdfl1d(x2); 
%   [alpha1,f_alpha1]=mdfl1d(x2,[0-n3:.2:n3]);%[-80:.2:+80]
%   %  [alphat,f_alphat,zaqt,at,tqt,qt]=mdfl1d(x2,[-10:0.2:10]); %[-18:.2:+18]);%,[10 1 512],'linpart','pls');改变权重因子
%  % Tq(:,i)=tq;
% %   AB1(:,i)=alpha1;
% %   fB1(:,i)=f_alpha1;
%   amin1(i)=alpha1(1)
%   amax1(i)=alpha1(10*n3+1);
%   da1(i)=amax1(i)-amin1(i);
%   famin1(i)=f_alpha1(1);
%   famax1(i)=f_alpha1(10*n3+1);
%   df1(i)=famin1(i)-famax1(i);
%   I(i)=sum(x2);
% %   I(i)=sum(x1);
% end

% for i=108*s:110*s-1 %for i=1:75 1=1:150
% %   x1=x((i-1)*T+1:i*T);
%  x2=x((i-1)*T/s+1:i*T/s); %16384);%取单元点数目
%   %[alpha1,f_alpha1,zaq,a,tq,q]=mdfl1d(x2); 
%   [alpha1,f_alpha1]=mdfl1d(x2,[0-n4:.2:n4]);%[-80:.2:+80]
%   %  [alphat,f_alphat,zaqt,at,tqt,qt]=mdfl1d(x2,[-10:0.2:10]); %[-18:.2:+18]);%,[10 1 512],'linpart','pls');改变权重因子
%  % Tq(:,i)=tq;
% %   A1(:,i)=alpha1;
% %   f1(:,i)=f_alpha1;
%   amin1(i)=alpha1(1)
%   amax1(i)=alpha1(10*n4+1);
%   da1(i)=amax1(i)-amin1(i);
%   famin1(i)=f_alpha1(1);
%   famax1(i)=f_alpha1(10*n4+1);
%   df1(i)=famin1(i)-famax1(i);
%   I(i)=sum(x2);
% end
% for i=110*s:118*s-1 %for i=1:75 1=1:150
% %   x1=x((i-1)*T+1:i*T);
%  x2=x((i-1)*T/s+1:i*T/s); %16384);%取单元点数目
%   %[alpha1,f_alpha1,zaq,a,tq,q]=mdfl1d(x2); 
%   [alpha1,f_alpha1]=mdfl1d(x2,[0-n5:.2:n5]);%[-80:.2:+80]
%   %  [alphat,f_alphat,zaqt,at,tqt,qt]=mdfl1d(x2,[-10:0.2:10]); %[-18:.2:+18]);%,[10 1 512],'linpart','pls');改变权重因子
%  % Tq(:,i)=tq;
% %   A1(:,i)=alpha1;
% %   f1(:,i)=f_alpha1;
%   amin1(i)=alpha1(1)
%   amax1(i)=alpha1(10*n5+1);
%   da1(i)=amax1(i)-amin1(i);
%   famin1(i)=f_alpha1(1);
%   famax1(i)=f_alpha1(10*n5+1);
%   df1(i)=famin1(i)-famax1(i);
%   I(i)=sum(x2);
% end
% for i=118*s:120*s-1 %for i=1:75 1=1:150
% %   x1=x((i-1)*T+1:i*T);
%  x2=x((i-1)*T/s+1:i*T/s); %16384);%取单元点数目
%   %[alpha1,f_alpha1,zaq,a,tq,q]=mdfl1d(x2); 
%   [alpha1,f_alpha1]=mdfl1d(x2,[0-n6:.2:n6]);%[-80:.2:+80]
%   %  [alphat,f_alphat,zaqt,at,tqt,qt]=mdfl1d(x2,[-10:0.2:10]); %[-18:.2:+18]);%,[10 1 512],'linpart','pls');改变权重因子
%  % Tq(:,i)=tq;
% %   A1(:,i)=alpha1;
% %   f1(:,i)=f_alpha1;
%   amin1(i)=alpha1(1)
%   amax1(i)=alpha1(10*n6+1);
%   da1(i)=amax1(i)-amin1(i);
%   famin1(i)=f_alpha1(1);
%   famax1(i)=f_alpha1(10*n6+1);
%   df1(i)=famin1(i)-famax1(i);
%   I(i)=sum(x2);
% end
% for i=120*s:136*s-1 %for i=1:75 1=1:150
% %   x1=x((i-1)*T+1:i*T);
%  x2=x((i-1)*T/s+1:i*T/s); %16384);%取单元点数目
%   %[alpha1,f_alpha1,zaq,a,tq,q]=mdfl1d(x2); 
%   [alpha1,f_alpha1]=mdfl1d(x2,[0-n7:.2:n7]);%[-80:.2:+80]
%   %  [alphat,f_alphat,zaqt,at,tqt,qt]=mdfl1d(x2,[-10:0.2:10]); %[-18:.2:+18]);%,[10 1 512],'linpart','pls');改变权重因子
%  % Tq(:,i)=tq;
% %   A1(:,i)=alpha1;
% %   f1(:,i)=f_alpha1;
%   amin1(i)=alpha1(1)
%   amax1(i)=alpha1(10*n7+1);
%   da1(i)=amax1(i)-amin1(i);
%   famin1(i)=f_alpha1(1);
%   famax1(i)=f_alpha1(10*n7+1);
%   df1(i)=famin1(i)-famax1(i);
%   I(i)=sum(x2);
% end
% for i=136*s:142*s-1 %for i=1:75 1=1:150
% %   x1=x((i-1)*T+1:i*T);
%  x2=x((i-1)*T/s+1:i*T/s); %16384);%取单元点数目
%   %[alpha1,f_alpha1,zaq,a,tq,q]=mdfl1d(x2); 
%   [alpha1,f_alpha1]=mdfl1d(x2,[-20:.2:20]);%[-80:.2:+80]
%   %  [alphat,f_alphat,zaqt,at,tqt,qt]=mdfl1d(x2,[-10:0.2:10]); %[-18:.2:+18]);%,[10 1 512],'linpart','pls');改变权重因子
%  % Tq(:,i)=tq;
% %   A1(:,i)=alpha1;
% %   f1(:,i)=f_alpha1;
%   amin1(i)=alpha1(1)
%   amax1(i)=alpha1(201);
%   da1(i)=amax1(i)-amin1(i);
%   famin1(i)=f_alpha1(1);
%   famax1(i)=f_alpha1(201);
%   df1(i)=famin1(i)-famax1(i);
%   I(i)=sum(x2);
% end
% for i=142*s:150*s %for i=1:75 1=1:150
% %   x1=x((i-1)*T+1:i*T);
%  x2=x((i-1)*T/s+1:i*T/s); %16384);%取单元点数目
%   %[alpha1,f_alpha1,zaq,a,tq,q]=mdfl1d(x2); 
%   [alpha1,f_alpha1]=mdfl1d(x2,[-40:.2:40]);%[-80:.2:+80]
%   %  [alphat,f_alphat,zaqt,at,tqt,qt]=mdfl1d(x2,[-10:0.2:10]); %[-18:.2:+18]);%,[10 1 512],'linpart','pls');改变权重因子
%  % Tq(:,i)=tq;
% %   A1(:,i)=alpha1;
% %   f1(:,i)=f_alpha1;
%   amin1(i)=alpha1(1)
%   amax1(i)=alpha1(401);
%   da1(i)=amax1(i)-amin1(i);
%   famin1(i)=f_alpha1(1);
%   famax1(i)=f_alpha1(401);
%   df1(i)=famin1(i)-famax1(i);
%   I(i)=sum(x2);
% end
% 


 %figure(1)
% subplot(2,2,1);
%plot(A(:,100),f(:,100),'r-',A(:,10),f(:,10),'g.');
%xlabel('\alpha');
%ylabel('f(\alpha)');
 %figure(2)
 %plot(A1(:,100),f1(:,100),'r-',A1(:,10),f1(:,10),'g.');
%xlabel('\alpha');
%ylabel('f1(\alpha)');

% subplot(2,2,2);
%plot(Q(:,1),TQ(:,110),'o',Q(:,1),TQ(:,10),'.');
%xlabel('q');
%ylabel('\tau(q)');
 

 