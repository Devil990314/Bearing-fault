function [embedding_dim, time_delay, time_window, avg_period] = Fun_estimate_Lyapunov_parameters(signal)
    % 计算自相关函数
    autocorr = xcorr(signal, signal);
    autocorr = autocorr(length(signal):end);

    % 寻找自相关函数的第一个零交叉点
    zero_crossing = find(diff(sign(autocorr)), 1);

    % 估计嵌入维数
    embedding_dim = 2 * zero_crossing;
    max_embedding_dim = 5; % 设置最大嵌入维数
    if embedding_dim > max_embedding_dim
        embedding_dim = max_embedding_dim;
    end

    % 估计时间延迟
    [~, peak_index] = max(autocorr);
    time_delay = peak_index;

    % 估计时间窗口
    max_time_window = length(signal) / 2; % 设置最大时间窗口
    if time_delay > max_time_window
        time_delay = max_time_window;
    end

    % 估计序列平均周期
    [~, period_index] = max(autocorr);
    avg_period = period_index;

    % 估计时间窗口（互信息方法）
    mi = zeros(1, max_time_window);
    for i = 1:max_time_window
        mi(i) = mutual_information(signal(1:end-i), signal(i+1:end));
    end
    [~, window_index] = max(mi);
    time_window_mi = window_index;

%     % 估计时间窗口（最小平均互信息方法）
%     min_avg_mi = inf;
%     for i = 1:max_time_window
%         if i+time_delay <= length(mi)
%             avg_mi = mean(mi(i:i+time_delay));
%         else
%             avg_mi = mean(mi(i:end));
%         end
%         if avg_mi < min_avg_mi
%             min_avg_mi = avg_mi;
%             time_window_avg_mi = i;
%         end
%     end

    % 输出最小时间窗口值
    time_window = min([time_delay, time_window_mi]);
end

function mi = mutual_information(x, y)
    % 计算互信息
    nbins = min(100, floor(sqrt(length(x))));
    pxy = hist3([x(:) y(:)], [nbins nbins]) / numel(x);
    px = sum(pxy, 2);
    py = sum(pxy, 1);
    pxy(pxy == 0) = 1; % 避免对0取log
    mi = sum(sum(pxy .* log2(pxy ./ (px * py))));
end
