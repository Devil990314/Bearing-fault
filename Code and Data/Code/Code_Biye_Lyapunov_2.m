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
fs=10000;
tic
X1=Data_25Hz(1:4096,1);
[embedding_dim, time_delay, time_window, avg_period] = Fun_estimate_Lyapunov_parameters(X1);
[LE1, K1] = LyapunovSpectrum_BBA(X1, fs, time_delay, time_window, embedding_dim, embedding_dim*2, 2, avg_period);% 参数计算
%[LE,K] = LyapunovSpectrum_BBA(X,fs,1,1,2,4,2,1);
time = toc;
disp(['------------计算Lyapunov指数谱用时: ',num2str(time),'s']);
%--------------------------------------------------------------------------
% 结果做图
figure;
plot(K1,LE1)
xlabel('K'); 
ylabel('Lyapunov Exponents (nats/s)');
%title([Henon, length = );
%--------------------------------------------------------------------------
% 输出显示
LE1 = LE1(:,end)
%% Lyapunov指数谱的BBA算法
%--------------------------------------------------------------------------
% Lyapunov指数谱的BBA算法
tic
X2=Data_25Hz(1:4096,2);
[embedding_dim, time_delay, time_window, avg_period] = Fun_estimate_Lyapunov_parameters(X2);
[LE2, K2] = LyapunovSpectrum_BBA(X2, fs, time_delay, time_window, embedding_dim, embedding_dim*2, 2, avg_period);% 参数计算
%[LE,K] = LyapunovSpectrum_BBA(X,fs,1,1,2,4,2,1);
time = toc;
disp(['------------计算Lyapunov指数谱用时: ',num2str(time),'s']);
%--------------------------------------------------------------------------
% 结果做图
figure;
plot(K2,LE2)
xlabel('K'); 
ylabel('Lyapunov Exponents (nats/s)');
%title([Henon, length = );
%--------------------------------------------------------------------------
% 输出显示
LE2 = LE2(:,end)%% Lyapunov指数谱的BBA算法
%--------------------------------------------------------------------------
%% Lyapunov指数谱的BBA算法
tic
X3=Data_25Hz(1:4096,3);
[embedding_dim, time_delay, time_window, avg_period] = Fun_estimate_Lyapunov_parameters(X3);
[LE3, K3] = LyapunovSpectrum_BBA(X3, fs, time_delay, time_window, embedding_dim, embedding_dim*2, 2, avg_period);% 参数计算
%[LE,K] = LyapunovSpectrum_BBA(X,fs,1,1,2,4,2,1);
time = toc;
disp(['------------计算Lyapunov指数谱用时: ',num2str(time),'s']);
%--------------------------------------------------------------------------
% 结果做图
figure;
plot(K3,LE3)
xlabel('K'); 
ylabel('Lyapunov Exponents (nats/s)');
%title([Henon, length = );
%--------------------------------------------------------------------------
% 输出显示
LE3 = LE3(:,end)
%% Lyapunov指数谱的BBA算法
tic
X4=Data_25Hz(1:4096,1);
[embedding_dim, time_delay, time_window, avg_period] = Fun_estimate_Lyapunov_parameters(X4);
[LE4, K4] = LyapunovSpectrum_BBA(X4, fs, time_delay, time_window, embedding_dim, embedding_dim*2, 2, avg_period);% 参数计算
%[LE,K] = LyapunovSpectrum_BBA(X,fs,1,1,2,4,2,1);
time = toc;
disp(['------------计算Lyapunov指数谱用时: ',num2str(time),'s']);
%--------------------------------------------------------------------------
% 结果做图
figure;
plot(K4,LE4)
xlabel('K'); 
ylabel('Lyapunov Exponents (nats/s)');
%title([Henon, length = );
%--------------------------------------------------------------------------
% 输出显示
LE4 = LE4(:,end)
