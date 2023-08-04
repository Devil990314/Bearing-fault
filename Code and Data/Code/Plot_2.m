function Plot_2(data,fs)
%%%此程序改于知乎——频域特征值提取的MATLAB代码实现（频谱、功率谱、倒频谱）
%%https://zhuanlan.zhihu.com/p/36163931
N=length(data);N=2^nextpow2(N/2);%% 取最邻近的2的n次幂值
data=data(1:N);
figure;
subplot(5,1,1);plot(data);title('原始信号');grid on
%FFT
Y = fft(data-mean(data),N);
Y = abs(Y).*2/N;
n=0:N-1;f=n*fs/N;
subplot(5,1,2);plot(f(1:fix(N/2)),Y(1:fix(N/2)));title('FFT');xlim([1 500]);grid on
%FFT直接平方
Y2 = Y.^2/(N);
subplot(5,1,3);plot(10*log10(Y2(1:fix(N/2))));title('直接法');xlim([5 500]);grid on
%周期图法
window = boxcar(length(data));  %矩形窗
[psd1,f] = periodogram(data,window,N,fs);
psd1 = psd1 / max(psd1);
subplot(5,1,4);plot(f,10*log10(psd1));title('周期图法');xlim([1 500]);grid on
%自相关结果
cxn = xcorr(data,'unbiased');  %计算自相关函数
%自相关法
CXk = fft(cxn,N);
psd2 = abs(CXk);
index = 0:round(N/2-1);
k = index*fs/N;
psd2 = psd2/max(psd2);
psd2 = 10*log10(psd2(index+1));
subplot(5,1,5);plot(k,psd2);xlim([1 500]);title('间接法');grid on
end