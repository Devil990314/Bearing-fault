%***********************************************
%该程序使用Wiener滤波方法对圆周运动轨迹进行控制
%信号模型：d=s+no  观测信号=期望信号+噪声信号
%进行一次Wiener滤波，得到最佳滤波器系数
clear
close all
N=500;
theta=linspace(0,2*pi,N);           %极坐标参数
s_x=cos(theta);                     %x，y方向上的期望信号
s_y=sin(theta);
no_x=normrnd(0,sqrt(0.05),1,N);     %高斯白噪声
no_y=normrnd(0,sqrt(0.06),1,N);
d_x=s_x+no_x;                       %观测信号
d_y=s_y+no_y;
M=500;%M为滤波器的阶数
%% 对x方向上数据进行滤波
rxx=xcorr(d_x);
Rxx=zeros(N);
% temp=toeplitz(rxx);
for i=1:N                             %观测信号的相关矩阵
    for j=1:N
        Rxx(i,j)=rxx(N+i-j);
    end
end

rxd=xcorr(s_x,d_x);                      %观测信号与期望信号的相关矩阵
Rxd=rxd(N:N+M-1);                        %向量而非矩阵
hopt_x=Rxx\Rxd';
% de_x=conv(hopt_x,d_x);
de_x=zeros(1,N);
for n=1:N
   for i=1:n-1
       de_x(n)=de_x(n)+hopt_x(i)*d_x(n-i);
   end
end
de_x(1:2)=d_x(1:2);
ems_x=sum(d_x.^2)-Rxd*hopt_x;
e_x=de_x-s_x;
% de_x(N-1:N)=d_x(N-1:N);
%% 对y方向上数据进行滤波 处理思路同x方向
ryy=xcorr(d_y);
Ryy=zeros(N);
for i=1:N
    for j=1:N
        Ryy(i,j)=ryy(N+i-j);
    end
end
% temp=toeplitz(ryy);
% Ryy=temp(1:M,N:N+M-1);

ryd=xcorr(s_y,d_y);
% temp=toeplitz(ryd);
% Ryd=temp(1:N,N:length(temp));
Ryd=ryd(N:N+M-1);
hopt_y=Ryy\Ryd';
% de_y=conv(hopt_y,d_y);
de_y=zeros(1,N);
for n=1:N
   for i=1:n-1
       de_y(n)=de_y(n)+hopt_y(i)*d_y(n-i);
   end
end
de_y(1:2)=d_y(1:2);
ems_y=sum(d_y.^2)-Ryd*hopt_y;
e_y=de_y-s_y;
% de_y(N-1:N)=d_y(N-1:N);
%% plot
figure
plot(s_x,s_y,'r','linewidth',2)
hold on
plot(d_x,d_y,'b')
hold on
plot(de_x,de_y,'k-')
title('维纳滤波预测轨迹')
legend('期望轨迹','观测轨迹','滤波轨迹')
%% %% x方向上绘图
figure

subplot(321)
plot(s_x)
title('期望信号')
subplot(322)
plot(no_x)
title('噪声信号')
subplot(323)
plot(d_x)
title('观测信号')
subplot(324)
plot(de_x)
title('滤波后信号')
subplot(325)
plot(ems_x,'o')
title('最小均方误差')
subplot(326)
plot(e_x)
title('绝对误差')
subtitle('X方向上维纳滤波效果')
%% y方向上绘图
figure

subplot(321)
plot(s_y)
title('期望信号')
subplot(322)
plot(no_y)
title('噪声信号')
subplot(323)
plot(d_y)
title('观测信号')
subplot(324)
plot(de_y)
title('滤波后信号')
subplot(325)
plot(ems_y,'o')
title('最小均方误差')
subplot(326)
plot(e_y)
subtitle('Y方向上维纳滤波效果')