%%%%https://blog.csdn.net/QWER306306/article/details/121309756
%%%现代信号处理-经典功率谱估计＜改进前＞

clc;clear;close all;
[x,fs,fr] = Load_Xichu_data();
%% 周期图解法PER
xk=abs(fft(x));       %%做的是N1点fft
for ki=1:N
    sf_per(ki)=((xk(ki))^2)/N;
end
rx_per=fftshift(abs(ifft(sf_per)));
figure;
subplot(2,2,1);
plot(rx_per);title('per的自相关函数');
subplot(2,2,2);
plot(sf_per);title('per的功率谱密度');
axis([-inf +inf -5 5]);

%% 周期图解法PER,XN补零成X2N-1
xn_2n=[x,zeros(1,N-1)];  %%补零
xk_2n=abs(fft(xn_2n));   %%做的是2*N1点fft
    for ki=1:(2*N-1)
        sf_per_2n(ki)=((xk_2n(ki))^2)/(2*N-1);
    end
rx_per_2n=fftshift(abs(ifft(sf_per_2n)));
subplot(2,2,3);
plot(rx_per_2n);title('per的自相关函数,XN插零成X2N');
subplot(2,2,4);
plot(sf_per_2n);title('per的功率谱密度');
axis([-inf +inf -5 5]);

%% 间接法BT法M=N-1
[rx_BT,lags]=xcorr(x,'coeff');
sf_BT=(abs(fft(rx_BT)));
figure;
subplot(3,2,1);
plot(lags,rx_BT);title('BT的自相关函数,M=N-1');
subplot(3,2,2);
plot(lags,sf_BT);title('BT的功率谱密度');
axis([-inf +inf -5 5]);

%% 间接法BT法M<N-1
M1=N/4;
rx_BT_M1=zeros(1,2*N-1);
rx_BT_M1(N)=rx_BT(N);
for ii=1:M1
    rx_BT_M1(N+ii)=rx_BT(N+ii);
    rx_BT_M1(N-ii)=rx_BT(N-ii);
end
sf_BT_M1=(abs(fft(rx_BT_M1)));
subplot(3,2,3);
plot(lags,rx_BT_M1);title('BT的自相关函数,M=N/4<N-1');
subplot(3,2,4);
plot(lags,sf_BT_M1);title('BT的功率谱密度');
axis([-inf +inf -5 5]);

M2=N/8;
rx_BT_M2=zeros(1,2*N-1);
rx_BT_M2(N)=rx_BT(N);
for ii=1:M2
    rx_BT_M2(N+ii)=rx_BT(N+ii);
    rx_BT_M2(N-ii)=rx_BT(N-ii);
end
sf_BT_M2=(abs(fft(rx_BT_M2)));
subplot(3,2,5);
plot(lags,rx_BT_M2);title('BT的自相关函数,M=N/8<N-1');
subplot(3,2,6);
plot(lags,sf_BT_M2);title('BT的功率谱密度');
axis([-inf +inf -5 5]);

L1=length(sf_BT);
L2=length(sf_BT_M1);
L3=length(sf_BT_M2);
L4=length(sf_per);
L5=length(sf_per_2n);
L=[L1 L2 L3 L4 L5];
LMAX=max(L);
SF=zeros(length(L),LMAX);
for k=1:L(1)
    SF(1,k)=sf_BT(k);
end
for k=1:L(2)
    SF(2,k)=sf_BT_M1(k);
end
for k=1:L(3)
    SF(3,k)=sf_BT_M2(k);
end
for k=1:L(4)
    SF(4,k)=sf_per(k);
end
for k=1:L(5)
    SF(5,k)=sf_per_2n(k);
end
%% 求几种方法的偏差
for i=1:length(L)
    SF_E(i)=sum(SF(i,:))/L(i);
    bia(i)=SF_E(i)-1;   %%E(P(K))-P(K)  功率谱密度理论值是常数1，因为是高斯白噪声
end   
figure;
subplot(2,1,1);
bar(abs(bia),0.5);axis([0 length(L)+1 -inf inf]); 
for i=1:length(bia)
    text(i,bia(i),[num2str(bia(i))],'HorizontalAlignment','center');
end
set(gca,'XTick',1:length(L));
set(gca,'XTickLabel',{'BT法不取窗','BT法取M=N/4窗','BT法取M=N/8窗','周期图法N点','周期图法2N点'});
title([num2str(length(L)),'种方法的偏差']);

%% 求几种方法的方差
for ii=1:length(L)
    for kk=1:L(ii)
        SF_2(ii,kk)=(SF(ii,kk)-SF_E(ii))^2;
    end
    var(ii)=sum(SF_2(ii,:))/L(ii);
end
subplot(2,1,2);
bar(var,0.5);axis([0 length(L)+1 -2 2]); 
for i=1:length(var)
    text(i,var(i),[num2str(var(i))],'HorizontalAlignment','center');
end
set(gca,'XTick',1:length(L));
set(gca,'XTickLabel',{'BT法不取窗','BT法取M=N/4窗','BT法取M=N/8窗','周期图法N点','周期图法2N点'});
title([num2str(length(L)),'种方法的方差']);
