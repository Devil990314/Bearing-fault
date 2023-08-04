function [s,delt_s,s_cor]=C_CMethod_gk(data)
%增强了代码的可读性，但效率有所下降！
%this function calculate time delay and embedding demension with C-C
%Method,which proved by H.S.Kim
%skyhawk&flyinghawk
% %****************调试程序段****************************
% clear all;
% data=load('f:/sunpot/year sunpot number.txt');
% %************************************************

N=length(data);
%max_d=22;%确定延时时间范围   序列长度为2048时，m=5时最大可用的t为22。
max_d=15;%序列长度为1024时，最大可用t为15。
sigma=std(data);%计算时间序列的标准差

for t=22:25
    
    s_t=0;%初始化，该变量用来记录m=2-5的S（m，r，t）求和
    delt_s_s=0;%初始化，该变量用来记录m=2~5的delt_S(m,t)求和
    for m=2:5
        
        s_t1=0;%初始化，该变量用来记录j=1~4的S（m，r，t）求和
        for j=1:4
            
            r=sigma*j/2;
            data_d=disjoint(data,N,t);%将时间序列分解成t个不相交的时间序列
            s_t3=0;%初始化，用来记录i=1~t的[C(i,m)-C(i,1)^m]的求和
            for i=1:t
                [t,m,j,i]
                Y=data_d(i,:);%分割后的第i个子时间序列
                
                C_m(i)= correlation_integral_gk(Y,m,r,t);%计算C(m,N_r,r,t)
                C_1(i)= correlation_integral_gk(Y,1,r,t);%计算C(1,N_d,r,t)
                s_t3=s_t3+(C_m(i)-C_1(i)^m);%对t个不相关的时间序列求和
            end
            s_t2(j)=s_t3/t;
            s_t1=s_t1+s_t2(j);%对rj求和
        end
        delt_s_m(m)=max(s_t2)-min(s_t2);%求delt S(m,t)
        delt_s_s=delt_s_s+delt_s_m(m);%delt S(m,t)对m求和
        s_t0(m)=s_t1;
        s_t=s_t+s_t0(m);%S对m求和
    end
    s(t)=s_t/16;
    delt_s(t)=delt_s_s/4;
    s_cor(t)=delt_s(t)+abs(s(t));
   
end

t=1:max_d;
figure(1);
plot(t,s);
title('s');
figure(2);
plot(t,delt_s);
title('delt_s');
figure(3);
plot(t,s_cor);
title('s_cor');
            
            
                
            