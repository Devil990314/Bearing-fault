
function main_process(data,PreStep,max_m)
% clear all
clc
close all
% load data.dat
% data=x(:,1);
N=length(data);
disp('---------����Ϣ����tau----------')
tau1=Mutual_Information_main(data)
%pause
% disp('---------CC����tau��m----------')
%   [tauc,mc]=CC_Method(data)
  disp('---------ȷ��tau----------')
  tau=input('������tau(Ĭ��Ϊtau1)=');
if isempty(tau)
    tau=tau1     
else
   tau
end

%  pause
 disp('---------cao����m----------')
min_m=1;max_m=20;
m_c=cao_m(data,min_m,max_m,tau)
m_cao=input('������cao��СǶ��ά��m=')
 if isempty(m_cao)
    m_cao=m_c     
else
    m_cao
 end
 close
 
%  disp('---------GP����m----------')
%  D=GP_Algorithm(data,tau,max_m);
 m_cao
m=input('ȷ����СǶ��ά��m(Ĭ��Ϊcao��)=');
if isempty(m)
    m=m_cao     
else
   m
end
disp('-------��ƽ������ P-----------')
P1=ave_period(data);
%pause
P=input('������ƽ������P(Ĭ��ΪP1)=');
if isempty(P)
    P=P1
else
   P=(m+1)*tau
end

close
%disp('-------��lyaָ��-------------')
% lambda_1=largest_lyapunov_exponent_revised(data,N,m,tau,P);
% pause

% LCE1=lyapunov_rosenstein(data,m,tau,P,2,1);
% pause
 disp('-------��С���ݷ������lyapunovָ��-------------')
  Lyapunov1=LargestLyapunov(data,m,tau,P)
  pause(5)
  disp('-------wolf�������lyapunovָ��-------------')
 lmd1_wolf=lyapunov_wolf(data,N,m,tau,P)
 %lmd1=lmd1_wolf
lmd1=input('��ѡ�����lyapunovָ��(Ĭ��Ϊwolf��,1Ϊ��С���ݷ�)=');
if isempty(lmd1)
    lmd1=lmd1_wolf
else
   lmd1=Lyapunov1
end

%lya(data,tau,max_m,P);
close all
disp('---------lyaָ��Ԥ��-----------')
pre_lya_change(data,tau,m,P,lmd1,PreStep);  %Ԥ��������Դ����
pause
disp('---------һ�׼�Ȩ����Ԥ��-----------')
%disp('---��ÿ��Ԥ����ֵ��Ϊ��ֵ֪����Դ���ݽ���Ԥ��----')
Predict(data,m,tau,P,lmd1,PreStep);   
pause
disp('---------һ�ζಽԤ��-----------')
PredictMain(data,m,tau,P,lmd1,PreStep);
pause
hold off