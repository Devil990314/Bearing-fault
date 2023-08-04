t=26;max_d=50;data=ans;N=length(data);sigma=std(data);
    s_t=0;%初始化，该变量用来记录m=2-5的S（m，r，t）求和
    delt_s_s=0;%初始化，该变量用来记录m=2~5的delt_S(m,t)求和
m=4;
s_t1=0;%初始化，该变量用来记录j=1~4的S（m，r，t）求和
        for j=1:4
            
            r=sigma*j/2;
            data_d=disjoint(data,N,t);%将时间序列分解成t个不相交的时间序列
            s_t3=0;%初始化，用来记录i=1~t的[C(i,m)-C(i,1)^m]的求和
            for i=1:t
                [t,m,j,i]
                Y=data_d(i,:);%分割后的第i个子时间序列
                
                C_m(i)= correlation_integral_gk(Y,m,r,t);%计算C(m,N_r,r,t)
                C_1(i)= correlation_integral_gk(Y,1,r,t);%计算C(1,N_d,r,t)
                s_t3=s_t3+(C_m(i)-C_1(i)^m);%对t个不相关的时间序列求和
            end
            s_t2(j)=s_t3/t;
            s_t1=s_t1+s_t2(j);%对rj求和
        end