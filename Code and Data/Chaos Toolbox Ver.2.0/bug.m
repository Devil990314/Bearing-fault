t=26;max_d=50;data=ans;N=length(data);sigma=std(data);
    s_t=0;%��ʼ�����ñ���������¼m=2-5��S��m��r��t�����
    delt_s_s=0;%��ʼ�����ñ���������¼m=2~5��delt_S(m,t)���
m=4;
s_t1=0;%��ʼ�����ñ���������¼j=1~4��S��m��r��t�����
        for j=1:4
            
            r=sigma*j/2;
            data_d=disjoint(data,N,t);%��ʱ�����зֽ��t�����ཻ��ʱ������
            s_t3=0;%��ʼ����������¼i=1~t��[C(i,m)-C(i,1)^m]�����
            for i=1:t
                [t,m,j,i]
                Y=data_d(i,:);%�ָ��ĵ�i����ʱ������
                
                C_m(i)= correlation_integral_gk(Y,m,r,t);%����C(m,N_r,r,t)
                C_1(i)= correlation_integral_gk(Y,1,r,t);%����C(1,N_d,r,t)
                s_t3=s_t3+(C_m(i)-C_1(i)^m);%��t������ص�ʱ���������
            end
            s_t2(j)=s_t3/t;
            s_t1=s_t1+s_t2(j);%��rj���
        end