%����������������ŵ�򷽷���Ԥ��ֵ
function [x_1,x_2]=pre_by_lya1(tau,m,lmd,whlsj,whlsl,idx,min_d,prestep)
% x_1 - ��һԤ��ֵ�� x_2 - �ڶ�Ԥ��ֵ��
% m ��Ƕ��ά����lmd - ���������ŵ��ֵ��whlsj - �������飬whlsl - ���ݸ����� idx - ���ĵ����������λ�ã� min_d - ���ĵ�����������ľ���

%��ռ��ع�
LAST_POINT = whlsl-(m-1)*tau;  %������
for j=1:LAST_POINT            
    for k=1:m
        Y(k,j)=whlsj((k-1)*tau+j);
    end
end

for step=1:prestep
    a_1=0.;
    for k=1:(m-1)
       a_1=a_1+(Y(k,idx+step)-Y(k+step,LAST_POINT))*(Y(k,idx+step)-Y(k+step,LAST_POINT));  % �˴�Y(k+1,LAST_POINT)ʵ���Ͼ���Y(k,LAST_POINT+1)
    end

%  deta=sqrt(min_d^2*2^(lmd*step)-a_1);
  deta=sqrt((min_d^2)*(2.718^(lmd*2))-a_1);
  %   deta=abs(sqrt((min_d^2)*(2.718^(lmd*step))-a_1));
  %if (deta>Y(m,idx+step)*0.05) 
  if (isreal(deta)==0) | (deta>Y(m,idx+step)*0.9);          %>Y(m,idx+step)*0.05)%*0.001)
      deta=Y(m,idx+step)*0.9%0.001;8
  end 
   % if isreal(deta)==0
    %      deta=Y(m,idx+step)*0.001
     %     deta
     %end
   
    x_1(step)=Y(m,idx+step)+deta;
    x_2(step)=Y(m,idx+step)-deta;
end
