function  tau=mutual_main(data)
%����Ϣ����tau
%data;     % ʱ�����У�������
%maxLags = 100;  % ������Ĭ�����ʱ��
%Part = 128;     % ������Ĭ��box��С

[entropy]=mutual(data,100);
for i = 1:length(entropy)-1           
    if (entropy(i)<=entropy(i+1))
        tau = i;            % ��һ���ֲ���Сֵλ��
        break;
    end
end
tau = tau -1               % r �ĵ�һ��ֵ��Ӧ tau = 0,����Ҫ�� 1
plot(0:length(entropy)-1,entropy)
xlabel('Lag');
title('����Ϣ����ʱ��');