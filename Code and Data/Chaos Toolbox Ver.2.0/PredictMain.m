function PredictMain(data,m,tau,P,lmd,MaxStep)
%һ�ζಽԤ��

% disp('--------���Ԥ�ⲽ��---------')
%  MaxStep=round(1/lmd)
%  
%  MaxStep=5;%����Ԥ��̫��������10��
% MaxStep=MaxStep+5;

newdata=data(1:length(data)-MaxStep);

PredictedData = FunctionChaosPredict(newdata,length(newdata),P,1,tau,m,MaxStep);%����AOLMM���жಽԤ��

plot(length(newdata)+1:length(data),data(length(newdata)+1:length(data)),'b-',length(newdata)+1:length(data),PredictedData,'r--');
legend('Original','Predict(һ�ζಽ)');

% delt=std(data(length(newdata)+1:length(data))-PredictedData')
disp('-----------��RMSE----------------------')
old=data(length(newdata)+1:length(data));
new=PredictedData';
q=mean(old);
RMSE=norm(new-old,2)/norm(old-q,2)
%disp('-------------�����-----------------')
%v=abs(new-old);
%MSE=sqrt(v'*v/length(new))

disp('----------MAPEƽ�����԰ٷֱ����---------------')
for i=1:length(old)
    a(i)=abs((old(i)-new(i))/old(i));
end
MAPE=sum(a)/length(old)*100

disp('-------------�����-----------------')
v=abs(new-old);
MSE=sqrt(sum(v.^2)/length(old))



%�˷�ʽԤ��Ч����