%skyhawk
clear all;

m=6;     %Ƕ��ά��
N=80;    %Ԥ���N����

A=load('kj.txt');
P=26; % ���յ�ƽ��ѭ�����ڣ�26

whl=A(:,4);
[whsl,lll]=size(whl);  

% lmd_1=lyapunov(m,m,whl,whsl);%��lyapunovָ��
% lmd_mm=lmd_1(m);
for j=1:whsl            
    whlsj(j)=whl(j);
end    

fch=0;
for i=whsl-N+1:whsl         %Ԥ���N����
    [lmd_m,idx,min_d,idx1,min_d1]=lyapunov(m,whlsj,i-1,P);  
    [y(i),z(i)]=pre_by_lya(m,lmd_m,whlsj,i-1,idx,min_d);%Ԥ���i+1����  
    
    fch=fch+(y(i)-whl(i))*(y(i)-whl(i));
%     fch=fch+(z(i)-whl(i))*(z(i)-whl(i));
%     clear whlsj;

    iii=whsl-i     %��ʾ����
end 

fch=sqrt(fch)/N

% for i=whsl-N+1:whsl
%     p(i-(whsl-N+1)+1)=y(i);
%     q(i-(whsl-N+1)+1)=z(i);
%     w(i-(whsl-N+1)+1)=whl(i);
% end

% kk=1:N;
% plot(kk,p,'r',kk,w)

yyy=[whl,y'];
save('kjyc.txt','yyy','-ASCII');

kk=1:whsl;
plot(kk,whl,'b',kk,y,'r')
