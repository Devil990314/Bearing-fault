function data_whitened = Fun_whiten_AR_1 (data,fs,order,r,i)

% 计算信号的自相关函数
[Rxx, lag] = xcorr(data, 'coeff');

% 截取自相关函数的正半轴
Rxx = Rxx(lag >= 0);

% 估计 AR 模型参数
[a, ~, ~] = aryule(Rxx, order);

% 计算白化滤波器的系数
b = sqrt(1 - r^2);

% 使用白化滤波器处理输入信号
data_whitened = filter(b, a, data);

if i==1
    % 绘制原始信号和白化后的信号
    t = (0:length(data)-1) * (1/fs); % 时间轴
    figure;
    subplot(3,1,1);
    plot(t,data);
    title('原始信号');
    xlabel('时间 (秒)');
    ylabel('幅度');
    subplot(3,1,2);
    plot(t, data_whitened);
    title('白化后的信号');
    xlabel('时间 (秒)');
    ylabel('幅度');

    % 进行频谱分析
    N = length(data); % 信号长度
    f = (0:N-1)*(fs/N); % 频率轴
    X = fft(data); % 原始信号的频谱
    X_whitened = fft(data_whitened); % 白化后信号的频谱

    % 绘制频谱图
    subplot(3,1,3);
    plot(f, abs(X), 'b', 'LineWidth', 1.5);
    hold on;
    plot(f, abs(X_whitened), 'r', 'LineWidth', 1.5);
    title('频谱对比');
    xlabel('频率 (Hz)');
    ylabel('幅度');
    legend('原始信号', '白化后的信号');
    xlim([1,100]);
    grid on;
end

end


%% 
function data_whitened = Fun_whiten_AR(data, params)
% Fun_whiten_AR 对信号进行白化处理
%
% 输入参数：
%   data: 输入信号数据
%   params: 参数结构体，包含以下字段：
%       - fs: 采样率，默认值为fs
%       - order: AR模型的阶数，默认值为10
%       - r: AR模型的系数，默认值为0.9
%       - plot: 是否绘制图形，默认值为true
%
% 输出参数：
%   data_whitened: 白化后的信号数据

% 解析参数结构体
p = inputParser;
addRequired(p, 'data');
addRequired(p, 'params', @isstruct);
parse(p, data, params);

fs = p.Results.params.fs;
order = p.Results.params.order;
r = p.Results.params.r;
plot_flag = p.Results.params.plot;

% 计算AR模型的系数
ar_coeff = arburg(data, order);%使用贝叶斯准则自动确定AR模型阶数

% 计算白化滤波器的系数
whitening_filter = [1; -ar_coeff(2:end).'];

% 对信号进行白化
data_whitened = filter(whitening_filter, 1, data);

% 绘制图形
if plot_flag
    t = (0:length(data)-1) / fs;
    figure;
    subplot(2,1,1);
    plot(t, data);
    xlabel('Time (s)');
    ylabel('Amplitude');
    title('Original Signal');
    subplot(2,1,2);
    plot(t, data_whitened);
    xlabel('Time (s)');
    ylabel('Amplitude');
    title('Whitened Signal');
end

end
