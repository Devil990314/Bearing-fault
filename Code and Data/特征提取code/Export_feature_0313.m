function feature_matrix=Export_feature_0313(data,Data_row_current)
% 计算一组样本的特征，并将这些特征保存到一个 Excel 文件中,
% 初始化特征矩阵
feature_matrix = zeros(size(data,2), 28);%%共17个时域+9个频域+样本序列1+标签1=28
fs=input('请输入采样频率(只输入整数，如10k只输入10)：');fs=fs*1000;%手动输入采样频率
assignin('caller','fs',fs);%将原采样频率返回至主函数
Inverter_fre=input('请输入转频：');%手动输入转频
assignin('caller','Inverter_fre',Inverter_fre);%将转频返回至主函数
disp('样本标签序号为： 0.Norm    1.OR     2.IR');
label_num=input('请输入标签序号: ');
switch_lable_num;%调用switch_lable_num函数


% 计算时域特征
for i = 1:size(data,2)
    % 计算均值——1
    mean_val = mean(data(:,i));
    % 计算最大值——2
    max_val = max(data(:,i));
    % 计算最小值——3
    min_val = min(data(:,i));
    % 计算均方值——4
    rms_val = rms(data(:,i));
    % 计算方差——5
    var_val = var(data(:,i));
    %峰-峰值——6
    pk_val =  max_val-min_val; 
    % 计算峰值因子——7
    peak_factor_val = pk_val/rms_val;
    % 计算峭度因子——8
    kurtosis_factor_val = kurtosis(data(:,i))/rms_val^4;
    % 计算方根幅值——17
    FG_val =mean(sqrt(abs((data(:,i)))))^2;
    % 计算裕度因子——9
    margin_factor_val = pk_val/FG_val;
    % 计算偏度——10
    skewness_val = skewness(data(:,i));
    % 计算峭度——11
    kurtosis_val = kurtosis(data(:,i));
    % 计算能量——12
    energy_val = sum(data(:,i).^2);
    % 绝对值的平均值(整流平均值)——13
    av_val = mean(abs(data(:,i)));
    % 计算标准差——14
    std_val = std(data(:,i));
    % 计算波形因子——15
    S_val =rms_val/av_val;
    % 计算脉冲因子——16
    L_val =pk_val/av_val ;
    %共17个时域特征
    
    %%频域特征
    % 对信号进行FFT
    N = length(data(:,i));      % FFT的长度
    Y = fft(data(:,i)', N);      % 进行FFT
    % 计算频率轴上的刻度值
    f = (0:N-1)*fs/N;
    % 计算频域特征
    P = abs(Y).^2/N;    % 计算功率谱密度
    [max_val, max_idx]=max(P);
    f0 = f(max_idx);  % 峰值频率 1
    A = max(abs(Y));    % 峰值幅值 2
    f1 = sum(f.*P)/sum(P);  % 频谱中心 3
    f2 = sqrt(sum((f-f1).^2.*P)/sum(P));   % 频带宽度 4
    f3 = sum(f.*abs(Y))/sum(abs(Y));   % 主频 5
    P_norm = P/max(P);  % 归一化功率谱密度 向量
    E = sum(P_norm.^2); % 能量密度 6
    % 计算频率标准差、频率均方差和平均频率
    f_std = sqrt(sum((f-f1).^2.*P)); %频率标准差 7
    f_var = sum((f-f1).^2.*P); % 频率均方差 8
    f_mean = sum(f.*P); % 平均频率 9

    %在最后一列加标签
    if label_num==0
        Sample_label=0;
    elseif label_num==1
        Sample_label=1;
    else label_num==2
        Sample_label=2;
    end
    % 将特征保存到特征矩阵中

    feature_matrix(i,:) = [i,mean_val, max_val, min_val, rms_val, var_val, pk_val, peak_factor_val, ...%8个 1-8
                           kurtosis_factor_val,FG_val,margin_factor_val, skewness_val, kurtosis_val,...%5个 9-13
                           energy_val,av_val,std_val,S_val,L_val,...%%5 17个时域特征 14-18
                           f0,A,f1,f2,f3,E,f_std,f_var,f_mean,Sample_label];%10 9个频域特征+样本标签=28
end
assignin('caller','feature_matrix',feature_matrix);%将该函数输出的特征矩阵输出返回至主函数
% 将特征矩阵保存到table中
feature_table = array2table(feature_matrix, 'VariableNames', {'Sample number','Mean', 'Max', 'Min', 'RMS', 'Variance', ...%%共6个 第1-5个特征+序列 
                                            'Peak-peak', 'Peak factor', 'Kurtosis factor','Square root amplitude','Margin_factor', 'Skewness', ...% 6 第6-10个,包括第17个
                                            'Kurtosis', 'Energy', 'Rectification average','Std','Waveform factor','Pluse facyor',...%6 第11-16个 +第17个==总共17个时域
                                            'peak frequency', 'peak amplitude','Centre of spectrum','band width'...%% 4 频域1-4
                                            'mains frequency','Energy density','Frequency std','Frequency var',...%% 4 频域5-8
                                            'Frequency mean',' Sample_label'});%%% 2 频域9

%%导出为归一化的表格 
% [filename, filepath] = uiputfile('*.xlsx', '选择要保存的文件');
% % 如果用户没有选择文件，则退出
% if isequal(filename,0) || isequal(filepath,0)
%     disp('用户取消了操作');
% else
%     % 将表格写入选定的文件中
%     fullpath = fullfile(filepath, filename);
%     writetable(feature_table, fullpath, 'Sheet', 'Sheet1');
%     disp(['成功将提取出的特征矩阵导出为表格,保存路径为：' fullpath]);
% end
assignin('caller','feature_table',feature_table);%将该函数输出的特征矩阵输出返回至主函数
end