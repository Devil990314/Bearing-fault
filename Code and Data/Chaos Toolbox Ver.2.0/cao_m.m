function [embed_m]=cao_m(data,min_m,max_m,tau)
%�ó������ʱ�����е�Ƕ��ά��
% clc
% clear
% load stock
% data=x; % dataΪԭʼ����,��������n��1��
% min_m=1;
% max_m=10;% min_m,max_m�ֱ�Ϊ��С�����Ƕ��ά��
% tau=2;    % tauΪʱ���ӳ�
% ����:Adu,�人��ѧ,adupopo@163.com

[E1,E2]=cao1(data,min_m,max_m,tau);
n=length(E1);
plot(1:n,E1,'-bs',1:n,E2,'-r*');xlabel('ά��');ylabel('E1&E2');
title('Cao�Ϸ�����СǶ��ά��');legend('E1','E2');
grid on


disp('--------cao����m---------')
e=0.1;embed_m=0;
h=1:length(E1)-1;
delt=abs(E1(h)-E1(h+1));
num=find(delt<e);
num1=find(delt==max(delt(num(1):length(delt))));
e=mean(delt(num1(1):length(E1)-1));
for kk=num1(1):length(E1)
    if kk+2<=length(E1)
        delt1=abs(E1(kk)-E1(kk-1));
        delt2=abs(E1(kk+1)-E1(kk));
        delt3=abs(E1(kk+2)-E1(kk+1));
        
        if (delt1>delt2)&(delt2>delt3)&(delt2<e)
            embed_m=kk;
            break
        end
    end
end