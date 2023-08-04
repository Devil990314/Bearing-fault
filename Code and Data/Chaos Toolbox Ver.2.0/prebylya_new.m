%����������������ŵ�򷽷���Ԥ��ֵ
 function [x_1,x_2]=prebylya_new(data,m,tau,lambda_1,P,idx)
% x_1 - ��һԤ��ֵ�� x_2 - �ڶ�Ԥ��ֵ��
% m ��Ƕ��ά����lmd - ���������ŵ��ֵ��whlsj - �������飬whlsl - ���ݸ����� idx - ���ĵ����������λ�ã� min_d - ���ĵ�����������ľ���
% load stock
% data=x,
% m=33;
% tau=2;
% P=2;

N=length(data);
Y=reconstitution(data,N,m,tau);   %��ռ��ع�
[m,M]=size(Y);
% lambda_1=largest_lyapunov_exponent(data,N,m,tau,P)
% lambda_1=lyapunov_wolf(data,N,m,tau,P)

% [idx,min_d,idx1,min_d1]=nearest_point(m,data,N,P)

d=norm(Y(:,idx+1)-Y(:,idx))*exp(lambda_1);
dm=norm(Y(1:m-1,M)-Y(2:m,M));
dm2=dm*dm;
d2=d*d;
deta=sqrt(d2-dm2);
 if (isreal(deta)==0) | (deta>Y(m,M)*0.01)%01)
    deta=Y(m,M)*0.01;%01;
end
x_1=Y(m,M)+deta;
x_2=Y(m,M)-deta;



