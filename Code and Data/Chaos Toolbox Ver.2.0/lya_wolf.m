function [LE1]=lya_wolf(data,tau,min_m,max_m,P)
%Wolf在一维数据中提取Lyapunov指数的方法
%(基于Lyapunov指数的观测数据短期预测.陈继光.山东大学 土建及水利学院)
%min_m=1;max_m=20;
%tau=1;P=2;
k=1;%取时间步长等于tau

N=length(data);

for m=min_m:max_m
    m
    Y=reconstitution(data,N,m,tau);
    M=N-(m-1)*tau;
    %-----------求距每个向量最短距离相点和距离-------------
    for j=1:M
        h=1;
        for jj=1:M         %寻找相空间中每个点的最近距离点，并记下该点下标限制短暂分离
            if abs(j-jj)>P
                dd(h,1)=jj;
                dd(h,2)=norm(Y(:,j)-Y(:,jj));
                h=h+1;
            end
        end
        min_d=min(dd(:,2));
        for s=1:length(dd(:,2))
            if min_d==dd(s,2)
                idx_j=dd(s,1);
                break
            end
        end
        D(j,1)=idx_j;%第一列存放序号
        D(j,2)=min_d;%第二列存放最短距离
    end

    %---------计算lya指数-----------------------
    lmd=0;
    n=0;%迭代次数初值
    for i=1:M
        if i+k<=M
            lmd=lmd+log2(D(i+k,2)/D(i,2))/k;
            n=n+1;
        end
    end
    LE1(m-min_m+1)=lmd/n;%取各指数增长率的平均值为最大Lyapunov指数估计
    clear dd D
end

%----------画图--------------
plot(min_m:max_m,LE1)
