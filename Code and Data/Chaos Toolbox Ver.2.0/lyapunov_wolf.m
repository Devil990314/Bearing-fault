function [lmd1] = lyapunov_wolf(data,N,m,tau,P)
% wolf�������lyapunovָ��
% data; % dataΪԭʼ����,��������n��1��
% m=��СǶ��ά��;
% tau=2;    % tauΪʱ���ӳ�
% ����:Adu,�人��ѧ,adupopo@163.com

lmd1=lyapunov_wolf_dll(data,tau,m,P);