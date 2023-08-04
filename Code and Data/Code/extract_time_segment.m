function extracted_signal = extract_time_segment(x, start_time, end_time, sample_rate)
%次函数用来对数据取中间某段进行分析
% 计算样本的起始和结束索引
sizex=size(x);
if sizex(:,2) ~= 1
    disp("------------当前的信号维度为：" + num2str(sizex));
    chose_i = input("------------当前信号为矩阵形式，请选择要分析的列：");
    x=x(:,chose_i);
end
start_index = start_time * sample_rate + 1;
end_index = end_time * sample_rate;

% 提取所需时间段的信号
extracted_signal = x(start_index:end_index);
end
