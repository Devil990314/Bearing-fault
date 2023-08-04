%skyhawk
clear all;
A=load('bk1.txt');
whl=A(:,4);
[whsl,lll]=size(whl);  

m=6

P=26;  %ƽ��ѭ������

N=80;  %���У�鲽��

for i=1:whsl
    whlsj(i)=whl(i);
end

[lmd_m,idx,min_d,idx1,min_d1]=lyapunov(m,whlsj,whsl,P);%��lyapunovָ��
lmd_m
% t_m=fix(1/lmd_m)       %���Ԥ�ⲽ��
t_m=5

for i=(whsl-N+2-t_m):(whsl-N+1)         %Ԥ���t_m��
    [lmd_m,idx,min_d,idx1,min_d1]=lyapunov(m,whlsj,whsl-N+2-t_m-1,P);  
    [yc,z(i)]=pre_by_lya(m,lmd_m,whlsj,i-1,idx,min_d);%Ԥ���i+1����  
    whlsj(i)=yc;  %����i��Ԥ��ֵ��Ϊ��������ݵĵ�i��ֵ������һ��Ԥ��
end

y(whsl-N+1)=yc;
fch=(y(whsl-N+1)-whl(whsl-N+1))*(y(whsl-N+1)-whl(whsl-N+1));
shuliang=1;

for i=(whsl-N+2):(whsl)
    whlsj(i-t_m)=whl(i-t_m);  %��Ϊʵ��ֵ
    [lmd_m,idx,min_d,idx1,min_d1]=lyapunov(m,whlsj,i-t_m,P);  
    [y(i),z(i)]=pre_by_lya(m,lmd_m,whlsj,i-1,idx,min_d);%Ԥ���i+1����  
    whlsj(i)=y(i);           %��ΪԤ��ֵ
    
    fch=fch+(y(i)-whl(i))*(y(i)-whl(i));
    shuliang=shuliang+1
end

fch=sqrt(fch)/shuliang

yyy=[whl,y'];
save('kjycqush.txt','yyy','-ASCII');

kk=1:whsl;
plot(kk,whl,'b',kk,y,'r')

