%% 此程序用于对采集到的信号进行机器学习前的特征提取
clc;clear all;close all;

%调用函数Load_data读取数据 需要指定读入的是哪一列,2为要读取的列数据
data=Load_B216_data(2);

%调用函数Data_expansion利用滑窗法进行样本划分；此时生成的样本为200个，即8192*200；
Data_samples=Data_expansion(data,8192,200,128);

%提取特征并生成特征矩阵，将其导出为excel文件，并在工作区中生成特征表格
Export_feature(Data_samples);

%进行特征矩阵的标准化（Z-score）;
disp('开始特征归一化： ');
feature_table=z_score_normalize(feature_table);
msgbox('特征提取完成！');
