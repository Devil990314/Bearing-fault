clc;clear;close all;
%% 信号读取
disp("------------分析信号选择------------");
disp("------------1.振动信号（b216）  2.电流信号（b216）  3.CWRU信号  4.Paderborn信号 5.2023电流信号------------");
i=input("------------请选择要分析的信号(1 or 2 or 3 or 4 or 5)： ");
[data_all,data_select,fs,fr,Fre_Bearing]=Fun_Choose_Signa(i);
X=data_select(1:4096);
filtered_signal=Fun_3Sigma(data_all(:,2),fs);
%% Lyapunov指数谱的BBA算法
%--------------------------------------------------------------------------
% Lyapunov指数谱的BBA算法
tic
[embedding_dim, time_delay, time_window, avg_period] = Fun_estimate_Lyapunov_parameters(X);
[LE, K] = LyapunovSpectrum_BBA(X, fs, time_delay, time_window, embedding_dim, embedding_dim*2, 2, avg_period);% 参数计算
%[LE,K] = LyapunovSpectrum_BBA(X,fs,1,1,2,4,2,1);
time = toc;
disp(['------------计算Lyapunov指数谱用时: ',num2str(time),'s']);
%--------------------------------------------------------------------------
% 结果做图
figure;
plot(K,LE)
xlabel('K'); 
ylabel('Lyapunov Exponents (nats/s)');
%title([Henon, length = );
%--------------------------------------------------------------------------
% 输出显示
LE = LE(:,end)
% %% 
% X=Data_25Hz;
% for i = 1:4
%     X_data=X(1:4096,i);
%     [embedding_dim, time_delay, time_window, avg_period] = Fun_estimate_Lyapunov_parameters(X_data);
%     [LE(i), K(i)] = LyapunovSpectrum_BBA(X_data, fs, time_delay, time_delay, embedding_dim, embedding_dim*2, 2, avg_period);% 参数计算
% end

