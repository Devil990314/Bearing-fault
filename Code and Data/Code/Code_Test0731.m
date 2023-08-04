clc;clear all;close all;
fs = 250;
load nonstatdistinct
t = (0:length(nonstatdistinct)-1)/fs;
figure;
plot(t,nonstatdistinct)
xlabel('Time (s)')
ylabel('Signal')
axis tight
mra = ewt(nonstatdistinct);
hht(mra,fs);