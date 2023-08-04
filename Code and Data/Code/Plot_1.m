function Plot_1(data,fs)
    N=length(data);N=2^nextpow2(N/2);%% 取最邻近的2的n次幂值
    data=data(1:N);t = 0 : 1/fs : (N-1)/fs;
    figure;
    subplot(4,1,1);plot(t,data,'r');
    xlabel('时间t/s');ylabel('幅值/v');title('时间序列')
    
    %fft变换
    n=0:N-1;f=n*fs/N;
    y=fft(data-mean(data),N); %减去均值，消去直流分量的影响
    mag=abs(y).*2/N;%在此处使用'.*'与'*'计算结果没区别，目的计算真实幅值；但是使用'.^'结果会不一样。
    mag_1=mag/(max(mag));mag_dB = 10*log10(mag_1);%归一化并取对数幅值 /dB,取10为底更符合常规
    
    subplot(4,1,2); plot(f(1:fix(N/2)),mag(1:fix(N/2))); xlim([1,500]);
    xlabel('频率f/Hz');ylabel('幅值/v');title('频谱分析');

    subplot(4,1,3);plot(f(1:fix(N/2)),mag_dB(1:fix(N/2))); 
    xlabel('频率f/Hz');ylabel('归一化幅值/dB');title('归一化幅度谱');xlim([1 500]);
        
    %%包络谱频谱分析
    hx=hilbert(data);inst_amp=abs(hx);
    env=inst_amp.^2;
    N=length(env);Y=fft(env)/N;f = fs*(0:fix(N/2))/N;P = abs(Y(1:fix(N/2+1)));
    subplot(4,1,4);plot(f,P);
    xlabel('频率f/Hz');ylabel('幅值/v');xlim([1 500]);title('Hilbert平方包络线的FFT分析');

end