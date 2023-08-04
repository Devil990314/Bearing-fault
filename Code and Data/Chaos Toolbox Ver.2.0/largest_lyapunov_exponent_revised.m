function [lambda_1,y]=largest_lyapunov_exponent_revised(data,N,m,tau,P)
%the function is used to calcultate largest lyapunov exponent with the
%mended algorithm,which put forward by lv jing hu.
%data:the time series
%N:the length of data
%m:enbedding dimention
%tau:time delay
%P:the mean period of the time series,calculated with FFT
%lambda_1:return the largest lyapunov exponent
%skyhawk

delt_t=1;
Y=reconstitution(data,N,m,tau );%reconstitute state space
M=N-(m-1)*tau;%M is the number of embedded points in m-dimensional space
for j=1:M

    k=1;
    for jj=1:M         %Ѱ����ռ���ÿ������������㣬�����¸õ��±����ƶ��ݷ���
        if abs(j-jj)>P
            dd(k,1)=jj;
            dd(k,2)=norm(Y(:,j)-Y(:,jj));
            k=k+1;
        end
    end
    min_d=min(dd(:,2));
    for s=1:length(dd(:,2))
        if min_d==dd(s,2)
            idx_j=dd(s,1);
            break
        end
    end
    clear dd
    max_i=min((M-j),(M-idx_j));%�����j������ݻ�ʱ�䲽��i
    for kk=1:max_i              %�����j��������ڵ���i����ɢ����ľ���
        d(kk,j)=norm(Y(:,j+kk)-Y(:,idx_j+kk));
    end
end

%��ÿ���ݻ�ʱ�䲽��i�������е�j��lnd(i,j)ƽ��
[l_i,l_j]=size(d);
for i=1:l_i
    q=0;
    y_s=0;
    for j=1:l_j
        if d(i,j)~=0
            q=q+1;
            y_s=y_s+log(d(i,j));
        end
    end
    y(i)=y_s/(q*delt_t);
end

x=1:length(y);
for i=1:length(y)-1
    dy(i)=y(i+1)-y(i);
end
% figure(1)
% subplot(311)
% plot(1:length(y),y)
% subplot(312)
% plot(1:(length(y)-1),dy)
% subplot(313)


x=[1:100];
pp=polyfit(x,y(x),1);%Ԥ���1-30����ο�ͼ���������ε���
lambda_1=pp(1);

%yp=polyval(pp,1:20);
% plot(x,y(x),'-b',1:20,yp,'-r',1:30,y(1:30))
% %lambda_1
% 
% figure(2)
% plot(x,y(x),'-b',1:20,yp,'-r',1:30,y(1:30))
