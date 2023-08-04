function [lmd1] = lyapunov_wolf(data,N,m,tau,P)
% wolf法求最大lyapunov指数
% data; % data为原始数据,列向量，n行1列
% m=最小嵌入维数;
% tau=2;    % tau为时间延迟
% 作者:Adu,武汉大学,adupopo@163.com

lmd1=lyapunov_wolf_dll(data,tau,m,P);