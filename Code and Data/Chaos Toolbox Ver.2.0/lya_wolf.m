function [LE1]=lya_wolf(data,tau,min_m,max_m,P)
%Wolf��һά��������ȡLyapunovָ���ķ���
%(����Lyapunovָ���Ĺ۲����ݶ���Ԥ��.�¼̹�.ɽ����ѧ ������ˮ��ѧԺ)
%min_m=1;max_m=20;
%tau=1;P=2;
k=1;%ȡʱ�䲽������tau

N=length(data);

for m=min_m:max_m
    m
    Y=reconstitution(data,N,m,tau);
    M=N-(m-1)*tau;
    %-----------���ÿ��������̾������;���-------------
    for j=1:M
        h=1;
        for jj=1:M         %Ѱ����ռ���ÿ������������㣬�����¸õ��±����ƶ��ݷ���
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
        D(j,1)=idx_j;%��һ�д�����
        D(j,2)=min_d;%�ڶ��д����̾���
    end

    %---------����lyaָ��-----------------------
    lmd=0;
    n=0;%����������ֵ
    for i=1:M
        if i+k<=M
            lmd=lmd+log2(D(i+k,2)/D(i,2))/k;
            n=n+1;
        end
    end
    LE1(m-min_m+1)=lmd/n;%ȡ��ָ�������ʵ�ƽ��ֵΪ���Lyapunovָ������
    clear dd D
end

%----------��ͼ--------------
plot(min_m:max_m,LE1)
