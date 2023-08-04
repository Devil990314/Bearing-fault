function [x1,x2] = pre_by_lya_gk(data,m,tau,N,lambda1,P);

Y = reconstitution(data,N,m,tau); %�ع���ռ�
M=N-(m-1)*tau; %������
%��ռ������ӵ�M+1���㣬�������һ�������ȿճ���
for i = 1:m-1
    Y(i,M+1) = data(M+1+(i-1)*tau);
end

%Ѱ��Y(M)������ڵ�Y(k)������dM
dM = 9999999;
k = 0;
for j=1:M-P
    ddM = norm(Y(:,j)-Y(:,M));
    if ddM < dM
        dM = ddM;
        k=j;
    end
end

%Ԥ��ֵ
sum = 0;
for i = 1:m-1
    sum = sum + (Y(i,M+1)-Y(i,k+1))^2;
end

x1 = Y(m,k+1) + sqrt( (dM*exp(lambda1))^2 - sum );
x2 = Y(m,k+1) - sqrt( (dM*exp(lambda1))^2 - sum );