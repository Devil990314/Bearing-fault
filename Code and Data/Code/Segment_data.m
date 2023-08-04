function segmented_data = Segment_data(input_data,i)
if i ~=4
    % input_data: 输入的时域信号
    % segmented_data: 分段后的数据矩阵

    segment_length = 8192; % 每段数据长度
    num_segments = 10; % 数据分成的段数
    data_length = length(input_data); % 获取数据总长度
    if data_length < segment_length*num_segments
        % 计算每一段数据的起始和结束位置
        seg_start_idx = [1:segment_length:data_length];
        seg_end_idx = [seg_start_idx(2:end)-1, data_length];

        % 将数据按照每段数据长度分割，并存储到矩阵中
        segmented_data = zeros(num_segments, segment_length);
        for i = 1:num_segments
            if seg_end_idx(i)-seg_start_idx(i)+1 < segment_length
                % 如果当前段数据不足 segment_length，则从之前的数据中选择一段进行复制
                copy_start_idx = mod(i-2,num_segments)*segment_length+1;
                segmented_data(i,:) = Pader_data(copy_start_idx:copy_start_idx+segment_length-1)';
            else
                % 截取当前段的数据
                seg_data = input_data(seg_start_idx(i):seg_end_idx(i));

                % 将当前段数据存储到结果矩阵中
                segmented_data(i, :) = seg_data';
            end
        end

    end
    if data_length >= segment_length*num_segments

        % 计算每一段数据的起始和结束位置
        seg_start_idx = [1:segment_length:data_length];
        seg_end_idx = [seg_start_idx(2:end)-1, data_length];

        % 将数据按照每段数据长度分割，并存储到矩阵中
        segmented_data = zeros(num_segments, segment_length);
        for i = 1:num_segments
            if seg_end_idx(i)-seg_start_idx(i)+1 < segment_length
                % 如果当前段数据不足 segment_length，则从之前的数据中选择一段进行复制
                copy_start_idx = mod(i-2,num_segments)*segment_length+1;
                segmented_data(i,:) = input_data(copy_start_idx:copy_start_idx+segment_length-1)';
            else
                % 截取当前段的数据
                seg_data = input_data(seg_start_idx(i):seg_end_idx(i));

                % 将当前段数据存储到结果矩阵中
                segmented_data(i, :) = seg_data';
            end
        end

    end

end
if i == 4
    disp("------------开始进行德国Paderbon数据分段------------");
    % input_data: 输入的时域信号
    % segmented_data: 分段后的数据矩阵
    n=input('------------请选择需要划分的信号类型：1.Paderbon电流信号C1 2.Paderbon电流信号C2  3.Paderbon振动信号 ');
    Pader_data=input_data(:,n);
    segment_length = 8192; % 每段数据长度
    num_segments = 10; % 数据分成的段数
    data_length = length(Pader_data); % 获取数据总长度

    % 计算每一段数据的起始和结束位置
    seg_start_idx = [1:segment_length:data_length];
    seg_end_idx = [seg_start_idx(2:end)-1, data_length];

    % 将数据按照每段数据长度分割，并存储到矩阵中
    segmented_data = zeros(num_segments, segment_length);
    for i = 1:num_segments
        if seg_end_idx(i)-seg_start_idx(i)+1 < segment_length
            % 如果当前段数据不足 segment_length，则从之前的数据中选择一段进行复制
            copy_start_idx = mod(i-2,num_segments)*segment_length+1;
            segmented_data(i,:) = Pader_data(copy_start_idx:copy_start_idx+segment_length-1)';
        else
            % 截取当前段的数据
            seg_data = Pader_data(seg_start_idx(i):seg_end_idx(i));

            % 将当前段数据存储到结果矩阵中
            segmented_data(i, :) = seg_data';
        end
    end
end


end
