%�ó����ü�Ȩһ�׾��򷨶���������ݽ��н���һ��Ԥ��
%skyhawk
clear all;
data=load('bk.txt');%��ȡ����
whl=data(:,4);
[whsl,lllll]=size(whl);
N=80;%Ԥ�����
m=6;
fch=0.;
for i=whsl-N+1:whsl         %Ԥ���N����
    for j=1:(i-1)            
        whlsj(j)=whl(j);
    end       
    [y(i),y1(i),y2(i)]=jiaquanyijie(m,whlsj,i-1);%Ԥ���i+1���� 
    fch=fch+(y(i)-whl(i))*(y(i)-whl(i));%�����׼�
    clear whlsj;
    i;
end 
fch=sqrt(fch)/N

yyy=[whl,y'];
save('bkyc.txt','yyy','-ASCII');

kk=1:whsl;
plot(kk,whl,'b',kk,y,'r')

