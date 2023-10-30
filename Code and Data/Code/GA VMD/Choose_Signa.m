function [data_all,data, fs,fr,Fre_Bearing]=Choose_Signa(i)
%0901修改
switch i
    case 1
        disp("------------开始分析 振动信号(b216) ------------ ");
        ii=input("------------请选择分析: 1.径向 Or 2.轴向:  ");
        disp('------------请选择要分析的振动数据(b216)------------')
        data_all=Load_B216_data(ii);
        disp("------------振动数据(b216)加载成功------------ ");
        fr=input('------------请输入转速/rpm: ');
        fs=10*1000;Fre_Bearing=Bearing_Fre(6205,fr);
    case 2
        disp("------------开始分析 电流信号(b216)------------ ");
        disp('------------请选择要分析的电流信号(b216)------------')
        data_all=Load_B216_data(2);
        disp("------------电流信号(b216)加载成功------------ ");
        fs = input('------------请输入采样频率/kHz: ');
        fr = input('------------请输入转速/rpm: ');
        fs=fs*1000;Fre_Bearing=Bearing_Fre(6205,fr);
    case 3
        disp("------------开始分析 CWRU信号------------ ");
        disp('------------请选择要分析的CWRU信号------------');
        [data_all,fs,fr]=Load_Xichu_data;
        disp("------------CWRU信号加载成功------------ ");
        Fre_Bearing=Bearing_Fre(6205,fr);
    case 4
        disp("------------开始分析 Paderborn信号------------ ");
        [data_all,fs,fr] =Load_Paderborn_data();
        disp("------------Paderborn信号加载成功------------ ");
        Fre_Bearing=Bearing_Fre(6203,fr);
    case 5
        disp("------------开始分析 202306 Current信号------------ ");
        [data_all,fs,fr] =Load_202306_Current_data();
        disp("------------202306 Current信号加载成功------------ ");
        Fre_Bearing=Bearing_Fre(6205,fr);
    otherwise
        disp("------------选择错误；请重新输入！------------")
        fs=0;
        fr=0;
        Fre_Bearing=0;
end
%针对不是一维数组的数据，选择列数来读取最终使用的数据
data_load=data_all;
sizex=size(data_load);
if sizex(:,2) == 1
    data=data_load;
    N=length(data);%加载数据
    Time_length = N/fs;
    disp("------------当前数据时间尺度为 " + num2str(Time_length) + " s");
end
if sizex(:,2) ~= 1
    disp("------------当前的信号维度为：" + num2str(sizex));
    chose_i = input("------------当前信号为矩阵形式，请选择要分析的列：");
    data=data_load(:,chose_i);
    N=length(data);%加载数据
    Time_length = N/fs;
    disp("------------当前数据时间尺度为 " + num2str(Time_length) + " s");
end
input_str = input("------------请输入加载数据的开始部分和结束部分（以空格分隔）：", 's');
inputs = str2num(input_str);start = inputs(1);finish = inputs(2);%读取部分数据
data = data(start * fs + 1 : finish * fs, 1);
%% 基波滤除代码 begin
if i==5 && 2
    i1=input("------------是否进行基波滤除？ 1.滤除 2.不滤除: ");
    switch i1
        case 1
            data_3Sigma = Fun_3Sigma(data,fs);%对信号进行3西格玛处理
            assignin('base','data_3Sigma',data_3Sigma);%将输出返回至主函数

            data_Filter_Fun_wave = Fun_process_signal_designfilt(data_3Sigma, fs, 1000);%对信号进行滤除基波处理
            assignin('base','data_Filter_Fun_wave',data_Filter_Fun_wave);%将输出返回至主函数
            disp("------------当前信号已进行基波滤除，信号名称为：'data_Filter_Fun_wave' ------------" );

            data_All_positive = data_Filter_Fun_wave - min(data_Filter_Fun_wave);%归0处理，保证所有数据都是正值
            assignin('base','data_All_positive',data_All_positive);%将输出返回至主函数
            disp("------------当前信号已进行基波滤除及3Sigma和归0处理，信号名称为：'data_All_positive' ------------" );
        case 2
            data_3Sigma = Fun_3Sigma(data,fs);%对信号进行3西格玛处理
            assignin('base','data_3Sigma',data_3Sigma);%将输出返回至主函数

            data=data_3Sigma;

            data_All_positive = data - min(data);%归0处理，保证所有数据都是正值
            assignin('base','data_All_positive',data_All_positive);%将输出返回至主函数
            disp("------------当前信号已进行3Sigma及归0处理，未进行基波滤除，信号名称为：'data_All_positive' ------------" );
        otherwise
            disp("------------滤波选择输入错误！")
    end
 end
end