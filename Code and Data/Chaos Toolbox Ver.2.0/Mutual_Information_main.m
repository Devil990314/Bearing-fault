function  tau=Mutual_Information_main(data)
%����Ϣ����tau
%data;     % ʱ�����У�������
max_t = 30;  % ������Ĭ�����ʱ��20
%Part = 128;     % ������Ĭ��box��С

[entropy]=mutual(data,max_t);
for i = 1:length(entropy)-1           
    if (entropy(i)<=entropy(i+1))
        tau = i   ;         % ��һ���ֲ���Сֵλ��
        break;
    end
end
tau=entropy(end);
tau = tau -1 ;              
plot(0:length(entropy)-1,entropy)
xlabel('Lag');
title('����Ϣ����ʱ��');