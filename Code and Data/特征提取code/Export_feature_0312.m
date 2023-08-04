function Export_feature_0312(data)
% 计算一组数据的特征，并将这些特征保存到一个 Excel 文件中,
%2023.03.12
% 初始化特征矩阵
feature_matrix = zeros(size(data,2), 27);%%共17个时域+9个频域+样本序列=27
%手动输入采样频率
fs=input('请输入采样频率(只输入整数，如10k只输入10)：');
fs=fs*1000;
D=39.0398;d=7.94004;a=0;Z=9;
Fr=input('请输入转频（电流基频）：');
a=a/180*pi;%将角度转换为弧度
F_in=Z*(1+d/D*cos(a))*Fr/2;F_of=Z*(1-d/D*cos(a))*Fr/2;%%计算内圈、外圈故障频率
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
 
    % 将特征保存到特征矩阵中
    % f0,A,f1,f2,f3,E,f_std,f_var,f_mean,f2_moment,f3_moment,f4_moment];
    feature_matrix(i,:) = [i,mean_val, max_val, min_val, rms_val, var_val, pk_val, peak_factor_val, ...
                           kurtosis_factor_val,FG_val,margin_factor_val, skewness_val, kurtosis_val,...
                           energy_val,av_val,std_val,S_val,L_val,...%%17个时域特征
                           f0,A,f1,f2,f3,E,f_std,f_var,f_mean];%9个频域特征+第一列为样本序列=30
end
% 将特征矩阵保存到table中
feature_table = array2table(feature_matrix, 'VariableNames', {'Sample number','Mean', 'Max', 'Min', 'RMS', 'Variance', ...%%第1-5个特征
                                            'Peak-peak', 'Peak factor', 'Kurtosis factor','Square root amplitude','Margin_factor', 'Skewness', ...%第6-10个,包括第17个
                                            'Kurtosis', 'Energy', 'Rectification average','Std','Waveform factor','Pluse facyor',...%第11-16个 +第17个==总共17个时域
                                            'peak frequency', 'peak amplitude','Centre of spectrum','band width'...%%频域1-4
                                            'mains frequency','Energy density','Frequency std','Frequency var',...%%频域5-8
                                            'Frequency mean'});%%%频域9

[filename, filepath] = uiputfile('*.xlsx', '选择要保存的文件');
% 如果用户没有选择文件，则退出
if isequal(filename,0) || isequal(filepath,0)
    disp('用户取消了操作');
else
    % 将表格写入选定的文件中
    fullpath = fullfile(filepath, filename);
    writetable(feature_table, fullpath, 'Sheet', 'Sheet1');
    disp(['成功将提取出的特征矩阵导出为表格 ' fullpath]);
end

end