function data = Load_B216_data(column_idx)
    % 选择文件
    [file_name, folder_path] = uigetfile({'*.txt;*.mat;*.xlsx;*.xls', 'All Files (*.txt,*.mat,*.xlsx,*.xls)'}, 'Select a file');
    if isequal(file_name, 0)
        disp('No file selected');
        return;
    end
    
    full_file_path = fullfile(folder_path, file_name);
    [~,~,file_ext] = fileparts(full_file_path);
    
    % 读取文件
    switch lower(file_ext)
        case '.txt'
            data = load(full_file_path);
        case {'.xlsx','.xls'}
            [~,~,data] = xlsread(full_file_path);
            data=cell2mat(data);
        case '.mat'
            data = load(full_file_path);
        otherwise
            error('Unknown file type');
    end
    
    % 选择列
    num_cols = size(data, 2);
    if nargin < 1 || isempty(column_idx)
        column_idx = 1:num_cols;
    end
    
    selected_data = data(:, column_idx);
    
    % 存储数据到工作区
    [~, ~, ~] = fileparts(file_name);
    var_name = 'data';
    assignin('base', var_name, selected_data);

    assignin('caller','Data_row_current',data(:,column_idx));%将输出返回至主函数
    
    % 显示成功读取的文件路径和数据信息
    fprintf('Successfully loaded data from file: %s\n', full_file_path);
    fprintf('Selected columns: %s\n', num2str(column_idx));
    fprintf('Saved data to variable: %s\n', var_name);
end
