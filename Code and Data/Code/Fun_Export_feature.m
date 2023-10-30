function feature_matrix=Fun_Export_feature(data,fs,fr)
% 计算一组样本的特征，并将这些特征保存到一个 Excel 文件中
% 初始化特征矩阵
feature_matrix = zeros(size(data,2), 39);%%共17个时域+8个频域+8个谐波+熵4+样本序1+标签1=39

%fs=input('请输入采样频率(只输入整数，如10k只输入10)：');fs=fs*1000;%手动输入采样频率
%assignin('caller','Raw_fs',fs);%将原采样频率返回至主函数
%fr=input('请输入转频：');%手动输入转频
%assignin('caller','fr',fr);%将转频返回至主函数

disp('------------样本标签序号为： 0.Normal  1.Inner  2.Outer  3.Hybrid');
label_num=input('------------请输入标签序号: ');
%调用switch_lable_num函数
Sample_label=Fun_switch_lable_num(label_num);disp('------------开始特征提取------------ ');
tic;
% 计算时域特征
parfor i = 1:size(data,2)
    tic;
    %共17个时域特征
    mean_val = mean(data(:,i));% 计算均值——1
    max_val = max(data(:,i));% 计算最大值——2
    min_val = min(data(:,i));% 计算最小值——3
    rms_val = rms(data(:,i));% 计算均方值——4
    var_val = var(data(:,i));% 计算方差——5
    pk_val =  max_val-min_val; %峰-峰值——6
    peak_factor_val = pk_val/rms_val;% 计算峰值因子——7
    kurtosis_factor_val = kurtosis(data(:,i))/rms_val^4;% 计算峭度因子——8
    FG_val =mean(sqrt(abs((data(:,i)))))^2;% 计算方根幅值——17
    margin_factor_val = pk_val/FG_val;% 计算裕度因子——9
    skewness_val = skewness(data(:,i));% 计算偏度——10
    kurtosis_val = kurtosis(data(:,i));% 计算峭度——11
    energy_val = sum(data(:,i).^2);% 计算能量——12
    av_val = mean(abs(data(:,i)));% 绝对值的平均值(整流平均值)——13
    std_val = std(data(:,i));% 计算标准差——14
    S_val =rms_val/av_val;% 计算波形因子——15
    L_val =pk_val/av_val ;% 计算脉冲因子——16
    %频域特征
    %N = 2^nextpow2(length(Data_row_current)/2);      % FFT的长度
    %X = fft(Data_row_current', N);      % 进行FFT
    %使用零填充法（zero-padding）
    N = length(data(:,i))*8;      % FFT的长度
    X = fft(data(:,i)', N);      % 进行FFT
    X = X(1:N/2+1); % 只保留正频率部分
    f = fs*(0:N/2)/N; % 频率向量
    %只针对低频段的特征进行提取
    f=f(1:1000);X=X(1:1000);
    % 计算频域特征 8个
    energy_freq = sum(abs(X).^2); % 能量 1
    mean_freq = sum(f.*abs(X).^2)/energy_freq; % 平均频率 2
    var_freq = sum((f-mean_freq).^2.*abs(X).^2)/energy_freq; % 频率方差 3
    max_amp = max(abs(X)); % 最大幅值 4
    min_amp = min(abs(X)); % 最小幅值 5
    skewness_val_fre = skewness(abs(X)); % 偏度 6
    kurtosis_val_fre = kurtosis(abs(X)); % 峭度 7
    spectral_entropy = -sum(abs(X).^2.*log(abs(X).^2)); % 频谱熵 8
    %%计算电流谐波中的特征 8个
    [f_or_s1,f_or_s2,f_if_s1,f_if_s2,Amp_f_if,Amp_f_of,Amp_2f_if,Amp_2f_of] =Cur_fre_Char (fr,f,X);
    %计算熵特征
    dim=2;r=0.2*std(data(:,i));sampEn = SampleEntropy( dim, r, data(:,i)');%样本熵
    M = 5; T = 1;PeEn= PermutationEntropy(data(:,i)',M,T);%排列熵
    eDim=2;r0=0.15*std_val;FuzEn = FuzzyEntropy(data(:,i)',eDim,r0,2,1);%模糊熵
    Approen=approximateEntropy(data(:,i)',1,2);%使用matlab自带近似熵函数求解近似熵，1为lag（重构延迟，2为维数）

    feature_matrix(i,:) = [i,mean_val, max_val, min_val, rms_val, var_val, pk_val, peak_factor_val, ...%8个 1-8
                           kurtosis_factor_val,FG_val,margin_factor_val, skewness_val, kurtosis_val,...%5个 9-13
                           energy_val,av_val,std_val,S_val,L_val,...%%5 17个时域特征 14-18
                           energy_freq,mean_freq,var_freq,max_amp,min_amp,...%5 19-23
                           skewness_val_fre,kurtosis_val_fre,spectral_entropy,...% 3 24-26
                           f_or_s1,f_or_s2,f_if_s1,f_if_s2,Amp_f_if,Amp_f_of,Amp_2f_if,Amp_2f_of,...%%8个谐波 27-34
                           sampEn,PeEn,FuzEn,Approen,Sample_label];%5 35-39 4个熵特征+样本标签=39
    time1=toc;
    disp(['------------已经完成第 ',num2str(i),' 个样本的特征提取，用时：',num2str(time1),'s']);
 end
assignin('caller','feature_matrix',feature_matrix);%将该函数输出的特征矩阵输出返回至主函数
% 将特征矩阵保存到table中
feature_table = array2table(feature_matrix, ...
    'VariableNames', {'Sample number','Mean', 'Max', 'Min', 'RMS', 'Variance', ...%%共6个 第1-5个特征+序列 
                                            'Peak-peak', 'Peak factor', 'Kurtosis factor','Square root amplitude','Margin_factor', 'Skewness', ...% 6 第6-10个,包括第17个
                                            'Kurtosis', 'Energy', 'Rectification average','Std','Waveform factor','Pluse facyor',...%6 第11-16个 +第17个==总共17个时域
                                            'energy_freq', 'mean_freq','var_freq','max_amp'...%% 4 频域1-4
                                            'min_amp','skewness_val_fre','kurtosis_val_fre','spectral_entropy',...%% 4 频域5-8
                                            'f_or_s1','f_or_s2','f_if_s1','f_if_s2','Amp_f_if','Amp_f_of','Amp_2f_if','Amp_2f_of',...8
                                            'SamEn','PeEn','FuzEn','Approen','Sample_label'});%%% 9样本标签 
assignin('caller','feature_table',feature_table);%将该函数输出的特征矩阵输出返回至主函数
time2=toc;
disp(['------------特征提取完成，总用时：',num2str(time2),'s']);
[filename, filepath] = uiputfile('*.xlsx', '选择要保存的文件');
% 如果用户没有选择文件，则退出
if isequal(filename,0) || isequal(filepath,0)
    disp('------------用户取消了操作');
else
    % 将表格写入选定的文件中
    fullpath = fullfile(filepath, filename);
    writetable(feature_table, fullpath, 'Sheet', 'Sheet1');
    disp(['------------成功提取出特征矩阵并导出为表格,保存路径为：' fullpath]);
end
end