%skyhawk&flyinghawk
clear all;
data=load('bk1.txt');%��ȡ����
whl=data(:,4);
[whsl,lllll]=size(whl);
m=6;
P=26;  %ƽ��ѭ������

N=80;%����Ԥ�ⲽ������ֵ

for i=1:whsl
    whlsj(i)=whl(i);
end

[lmd_m,idx,min_d,idx1,min_d1]=lyapunov(m,whlsj,whsl,P);%��lyapunovָ��
lmd_m
% t_m=fix(1/lmd_m)+1       %���Ԥ�ⲽ��
t_m=1
% for j=1:(whsl-t_m)
%     whlsj(j)=whl(j);
% end   
for i=(whsl-N+2-t_m):(whsl-N+1)         %Ԥ���t_m��
    [yc,y1(i),y2(i)]=jiaquanyijie(m,whlsj,i-1);%�����i��Ԥ��ֵ 
    whlsj(i)=yc;  %����i��Ԥ��ֵ��Ϊ��������ݵĵ�i��ֵ������һ��Ԥ��
end

y(whsl-N+1)=yc;
fch=(y(whsl-N+1)-whl(whsl-N+1))*(y(whsl-N+1)-whl(whsl-N+1));
shuliang=1;

for i=(whsl-N+2):(whsl)
    whlsj(i-t_m)=whl(i-t_m);  %��Ϊʵ��ֵ
    [y(i),y1(i),y2(i)]=jiaquanyijie(m,whlsj,i-1);
    whlsj(i)=y(i);           %��ΪԤ��ֵ
    
    fch=fch+(y(i)-whl(i))*(y(i)-whl(i));
    shuliang=shuliang+1;
end

fch=sqrt(fch)/shuliang

yyy=[whl,y'];
save('bkycqush.txt','yyy','-ASCII');

kk=1:whsl;
plot(kk,whl,'b',kk,y,'r')

