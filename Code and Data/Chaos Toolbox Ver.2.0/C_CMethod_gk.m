function [s,delt_s,s_cor]=C_CMethod_gk(data)
%��ǿ�˴���Ŀɶ��ԣ���Ч�������½���
%this function calculate time delay and embedding demension with C-C
%Method,which proved by H.S.Kim
%skyhawk&flyinghawk
% %****************���Գ����****************************
% clear all;
% data=load('f:/sunpot/year sunpot number.txt');
% %************************************************

N=length(data);
%max_d=22;%ȷ����ʱʱ�䷶Χ   ���г���Ϊ2048ʱ��m=5ʱ�����õ�tΪ22��
max_d=15;%���г���Ϊ1024ʱ��������tΪ15��
sigma=std(data);%����ʱ�����еı�׼��

for t=22:25
    
    s_t=0;%��ʼ�����ñ���������¼m=2-5��S��m��r��t�����
    delt_s_s=0;%��ʼ�����ñ���������¼m=2~5��delt_S(m,t)���
    for m=2:5
        
        s_t1=0;%��ʼ�����ñ���������¼j=1~4��S��m��r��t�����
        for j=1:4
            
            r=sigma*j/2;
            data_d=disjoint(data,N,t);%��ʱ�����зֽ��t�����ཻ��ʱ������
            s_t3=0;%��ʼ����������¼i=1~t��[C(i,m)-C(i,1)^m]�����
            for i=1:t
                [t,m,j,i]
                Y=data_d(i,:);%�ָ��ĵ�i����ʱ������
                
                C_m(i)= correlation_integral_gk(Y,m,r,t);%����C(m,N_r,r,t)
                C_1(i)= correlation_integral_gk(Y,1,r,t);%����C(1,N_d,r,t)
                s_t3=s_t3+(C_m(i)-C_1(i)^m);%��t������ص�ʱ���������
            end
            s_t2(j)=s_t3/t;
            s_t1=s_t1+s_t2(j);%��rj���
        end
        delt_s_m(m)=max(s_t2)-min(s_t2);%��delt S(m,t)
        delt_s_s=delt_s_s+delt_s_m(m);%delt S(m,t)��m���
        s_t0(m)=s_t1;
        s_t=s_t+s_t0(m);%S��m���
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
            
            
                
            