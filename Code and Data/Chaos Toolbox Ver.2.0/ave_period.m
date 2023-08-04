function P=ave_period(data)

%该程序的平均周期是功率最大处的频率的倒数，与文献中的算法不一样

year=length(data);
wolfer=data;
% plot(year,wolfer)
% title(' signal')

Y = fft(wolfer);
Y(1)=[];

% plot(Y,'ro')
% title('Fourier Coefficients in the Complex Plane');
% xlabel('Real Axis');
% ylabel('Imaginary Axis');

n=length(Y);
power = abs(Y(1:floor(n/2))).^2;
nyquist = 1/2;
freq = (1:n/2)/(n/2)*nyquist;
% plot(freq,power)
% xlabel('cycles/year')
% title('Periodogram')

period=1./freq;
% plot(period,power);
% ylabel('Power');
% xlabel('Period (Years/Cycle)');

% hold on;
index=find(power==max(power));
mainPeriodStr=num2str(period(index));
% plot(period(index),power(index),'r.', 'MarkerSize',25);
% text(period(index)+2,power(index),['Period = ',mainPeriodStr]);
% hold off;

P=round(period(index))
