 function MSE=Predict1(data,m,tau,P,lmd,MaxStep)
%����Ԥ��

% disp('--------���Ԥ�ⲽ��---------')
%  MaxStep=round(1/lmd)
% % MaxStep=5;
% % MaxStep=MaxStep+5;%����Ԥ��̫��������10��
deltaT=1;



for i=1:MaxStep
    i
    newdata=data(1:length(data)-MaxStep+i-1);
    pre_value(i) = FunctionChaosPredict(newdata,length(newdata),P,deltaT,tau,m,1);%����AOLMM���жಽԤ��
end

%figure(1)
%  plot(length(data)-MaxStep+1:length(data),data(length(data)-MaxStep+1:length(data)),'b-',length(data)-MaxStep+1:length(data),pre_value,'r-*');
% legend('Original','Predict(����)');
% %-----------���׼��-----------------
% delt=std(data(length(newdata)+1:length(data))-newdata1(length(newdata)+1:length(data)))

disp('-----------��RMSE----------------------')
old=data(length(data)-MaxStep+1:length(data))';
q=mean(old);
RMSE=norm(pre_value-old,2)/norm(old-q,2)
disp('-------------�����-----------------')
v=abs(pre_value-old);
MSE=sqrt(sum(v.^2)/length(old))


disp('----------MAPEƽ�����԰ٷֱ����---------------')
for i=1:length(old)
    a(i)=abs((old(i)-pre_value(i))/old(i));
end
MAPE=sum(a)/length(old)*100
