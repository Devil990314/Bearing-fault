function [teagerEnergy, teagerSpectrum] = Fun_calculateTeagerEnergy(signal, fs)
% 计算信号的Teager能量算子输出
teagerEnergy = signal(2:end-1).^2 - signal(1:end-2).*signal(3:end);

% 对瞬时Teager能量序列进行Fourier变换得到Teager能量谱
N = length(teagerEnergy);
teagerSpectrum = abs(fft(teagerEnergy))/N;
teagerSpectrum = teagerSpectrum(1:N/2+1);
teagerSpectrum(2:end-1) = 2*teagerSpectrum(2:end-1);
figure;
plot(teagerEnergy);
title('Teager Energy');
xlabel('Time (s)');
ylabel('Amplitude');
% 绘制Teager能量谱
f = (0:N/2)*fs/N;
figure;
plot(f, teagerSpectrum);
title('Teager Energy Spectrum');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
end
