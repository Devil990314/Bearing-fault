function [Lyapunov1]=LargestLyapunov(data,m,tau,P)
% ����С���������������ʱ������ Lyapunov ָ��
% tau = 1;                        % ʱ��
% m = 14;                          % Ƕ��ά
% data ;    % ���������� n*1 
taumax = 100;                    % �����ɢ����ʱ��
% P = 2;                        % ����ƽ������

Y = lyapunov_small(data,tau,m,P);

figure(1)
plot(Y(1:taumax),'-b'); grid; xlabel('i'); ylabel('y(i)');

n=input('������Ҫ��ϳ���n(Ĭ��Ϊ8)=');
if isempty(n)
    n=8
else
   n
end


linear_zone = [1:n]';          % ��������[1:N]
F = polyfit(linear_zone,Y(linear_zone),1);
Lyapunov1 = F(1);
yp=polyval(F,1:n+10);
hold on
plot(1:n+10,yp,'-r')
hold off
