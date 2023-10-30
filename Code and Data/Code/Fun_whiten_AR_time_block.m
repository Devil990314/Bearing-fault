function [data_whitened, whitening_filter] = Fun_whiten_AR_time_block(data, fs, block_size)
%对信号进行分块后在时域上进行白化
    n = length(data);
    num_blocks = ceil(n / block_size);
    data_whitened = zeros(n, 1);

    for i = 1:num_blocks
        start_idx = (i - 1) * block_size + 1;
        end_idx = min(i * block_size, n);

        block_data = data(start_idx:end_idx);

        % 计算信号块的自相关函数
        autocorr_block = xcorr(block_data, 'biased');

        % 计算自相关函数的Toeplitz矩阵
        R = toeplitz(autocorr_block(end-block_size+1:end));

        % 计算最优的白化滤波器系数
        whitening_filter = -R(2:end, 2:end) \ R(2:end, 1);

        % 对信号块进行白化
        data_whitened(start_idx:end_idx) = filter([1; whitening_filter], 1, block_data);
    end

    % 绘制原始信号和白化后的信号的时域图
    t = (0:n - 1) / fs;
    figure;
    subplot(2, 1, 1);
    plot(t, data);
    xlabel('Time (s)');
    ylabel('Amplitude');
    title('Original Signal');
    subplot(2, 1, 2);
    plot(t, data_whitened);
    xlabel('Time (s)');
    ylabel('Amplitude');
    title('Whitened Signal');
end
