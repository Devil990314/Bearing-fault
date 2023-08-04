%%%此程序来源知乎——频域特征值提取的MATLAB代码实现（频谱、功率谱、倒频谱）
%%https://zhuanlan.zhihu.com/p/36163931

fs = 1000;
N = 1000;  %fft采样点数

%产生序列
n = 0:1/fs:1;
data = cos(2*pi*100*n) + 3*cos(2*pi*200*n)+(randn(size(n)));
subplot(5,1,1);plot(data);title('加噪信号');xlim([0 1000]);grid on
%FFT
Y = fft(data,N);
Y = abs(Y);
subplot(5,1,2);plot((10*log10(Y(1:N/2))));title('FFT');xlim([0 500]);grid on
%FFT直接平方
Y2 = Y.^2/(N);
subplot(5,1,3);plot(10*log10(Y2(1:N/2)));title('直接法');xlim([0 500]);grid on
%周期图法
window = boxcar(length(data));  %矩形窗
[psd1,f] = periodogram(data,window,N,fs);
psd1 = psd1 / max(psd1);
subplot(5,1,4);plot(f,10*log10(psd1));title('周期图法');ylim([-60 10]);grid on
%自相关结果
cxn = xcorr(data,'unbiased');  %计算自相关函数
%自相关法
CXk = fft(cxn,N);
psd2 = abs(CXk);
index = 0:round(N/2-1);
k = index*fs/N;
psd2 = psd2/max(psd2);
psd2 = 10*log10(psd2(index+1));
subplot(5,1,5);plot(k,psd2);title('间接法');grid on