
clear all;
close all;
clc;
load mmm.mat
f=mm;
T=749;

% some sample parameters for VMD
alpha = 2000;        % moderate bandwidth constraint
tau = 0;            % noise-tolerance (no strict fidelity enforcement)
K =5;              % 3 modes
DC = 0;             % no DC part imposed
init = 1;           % initialize omegas uniformly
tol = 1e-7;

%--------------- Run actual VMD code

[u, u_hat, omega] = VMD(f, alpha, tau, K, DC, init, tol);


%--------------- Visualization

figure(1) 
subplot(5,1,5);plot(u(5,:))
ylabel({'IMF1'})
subplot(5,1,4);plot(u(4,:))
ylabel({'IMF3'})
subplot(5,1,3);plot(u(3,:))
ylabel({'IMF2'})
subplot(5,1,2);plot(u(2,:))
ylabel({'IMF1'})
subplot(5,1,1);plot(u(1,:))
ylabel({'Ç÷ÊÆÏî'})



