function [idx2,min_d2]=nearpoint(data,tau,m,P)
%�����һ�������������;���
N=length(data);
Y=reconstitution(data,N,m,tau );%reconstitute state space
M=N-(m-1)*tau;%M is the number of embedded points in m-dimensional space

k=1;
for j=1:M         %Ѱ����ռ���ÿ������������㣬�����¸õ��±����ƶ��ݷ���
    if abs(M-j)>P
        dd(k,1)=j;
        dd(k,2)=norm(Y(:,M)-Y(:,j));
        k=k+1;
    end
end
min_d2=min(dd(:,2));
for s=1:length(dd(:,2))
    if min_d2==dd(s,2)
        idx2=dd(s,1);
        break
    end
end