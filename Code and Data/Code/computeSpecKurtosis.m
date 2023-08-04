function k = computeSpecKurtosis(signal, Fs)
% signal: 输入的时域信号向量
% Fs: 采样频率

% 计算能量谱密度和频率向量
[PSD,f] = pwelch(signal,[],[],[],Fs);
f = f(:); PSD = PSD(:);

% 计算谱峭度
M4 = moment(PSD, 4);
M2 = moment(PSD, 2);
k = M4 / M2^2 - 2;

% 绘制能量谱密度和谱峭度图像
figure;
subplot(1,2,1);plot(f,log10(PSD));xlabel('Frequency (Hz)');ylabel('Power/Frequency (dB/Hz)');title('Energy Spectral Density');
subplot(1,2,2);plot(f,k);xlabel('Frequency (Hz)');ylabel('Spec. Kurtosis');title('Spectral Kurtosis');
end
