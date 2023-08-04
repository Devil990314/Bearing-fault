function samples=Data_expansion(data,window_size,Num_seg,step_size)
%Data_samples=Data_expansion(data,8192,200,128);
N=((Num_seg*step_size)-1)+window_size;
%Num_seg=(Num-window_size)/step_size-1
%200=(33664-8192)/128+1
data=data(1:N);
%step_size=128;
%%N=33664时，可生成8192x200的样本，重叠数为128.
num_samples = floor((length(data) - window_size) / step_size) + 1;  % 样本数量
samples = zeros(num_samples, window_size);  % 初始化样本矩阵

for i = 1:num_samples
    start_idx = (i - 1) * step_size + 1;
    end_idx = start_idx + window_size - 1;
    samples(i, :) = data(start_idx:end_idx);
end
samples=samples';
data=samples(:,1:Num_seg);
end