clc;clear;close all;
disp("------------分析信号选择------------");
disp("------------1.振动信号（b216）  2.电流信号（b216）  3.CWRU信号  4.Paderborn信号 5.2023电流信号------------");
i=input("------------请选择要分析的信号(1 or 2 or 3 or 4 or 5)： ");
[data_all,data_select,fs,fr,Fre_Bearing]=Fun_Choose_Signa(i);

Data_samples=Fun_create_samples(data_all);%把定子电流按照8192个数据1个样本，每相100个，总共划分300个样本

%提取特征并生成特征矩阵，将其导出为excel文件，并在工作区中生成特征表格
Fun_Export_feature(Data_samples,fs,fr);

%进行特征矩阵的标准化（Z-score）;
disp('开始特征归一化： ');
feature_table=Fun_z_score_normalize(feature_table);
msgbox('特征提取完成！');
