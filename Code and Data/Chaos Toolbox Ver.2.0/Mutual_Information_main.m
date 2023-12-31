function  tau=Mutual_Information_main(data)
%互信息法求tau
%data;     % 时间序列，列向量
max_t = 30;  % 本程序默认最大时延20
%Part = 128;     % 本程序默认box大小

[entropy]=mutual(data,max_t);
for i = 1:length(entropy)-1           
    if (entropy(i)<=entropy(i+1))
        tau = i   ;         % 第一个局部极小值位置
        break;
    end
end
tau=entropy(end);
tau = tau -1 ;              
plot(0:length(entropy)-1,entropy)
xlabel('Lag');
title('互信息法求时延');