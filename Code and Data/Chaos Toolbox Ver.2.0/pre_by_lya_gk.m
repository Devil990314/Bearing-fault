function [x1,x2] = pre_by_lya_gk(data,m,tau,N,lambda1,P);

Y = reconstitution(data,N,m,tau); %重构相空间
M=N-(m-1)*tau; %相点个数
%相空间中增加第M+1个点，它的最后一个分量先空出来
for i = 1:m-1
    Y(i,M+1) = data(M+1+(i-1)*tau);
end

%寻找Y(M)的最近邻点Y(k)及距离dM
dM = 9999999;
k = 0;
for j=1:M-P
    ddM = norm(Y(:,j)-Y(:,M));
    if ddM < dM
        dM = ddM;
        k=j;
    end
end

%预测值
sum = 0;
for i = 1:m-1
    sum = sum + (Y(i,M+1)-Y(i,k+1))^2;
end

x1 = Y(m,k+1) + sqrt( (dM*exp(lambda1))^2 - sum );
x2 = Y(m,k+1) - sqrt( (dM*exp(lambda1))^2 - sum );