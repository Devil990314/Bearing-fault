%����������������ŵ�򷽷���Ԥ��ֵ
function [x_1,x_2]=pre_by_lya(m,lmd,whlsj,whlsl,idx,min_d)
% x_1 - ��һԤ��ֵ�� x_2 - �ڶ�Ԥ��ֵ��
% m ��Ƕ��ά����lmd - ���������ŵ��ֵ��whlsj - �������飬whlsl - ���ݸ����� idx - ���ĵ����������λ�ã� min_d - ���ĵ�����������ľ���

%��ռ��ع�
LAST_POINT = whlsl-m+1;
for j=1:LAST_POINT           
    for k=1:m
        Y(k,j)=whlsj(k+j-1);
    end
end


a_1=0.;
for k=1:(m-1)
    a_1=a_1+(Y(k,idx+1)-Y(k+1,LAST_POINT))*(Y(k,idx+1)-Y(k+1,LAST_POINT));  % �˴�Y(k+1,LAST_POINT)ʵ���Ͼ���Y(k,LAST_POINT+1)
end

deta=sqrt(min_d^2*2^(lmd*2)-a_1);
if (isreal(deta)==0) | (deta>Y(m,idx+1)*0.001)
    deta=Y(m,idx+1)*0.001
end
x_1=Y(m,idx+1)+deta;
x_2=Y(m,idx+1)-deta;
