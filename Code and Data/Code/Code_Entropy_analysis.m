%次程序用来计算样本熵、近似熵、排列熵、模糊熵
%0901修改
clc;clear;close all;
A_Sam_en=[];B_Per_en=[];C_Fuz_en=[];D_App_en=[];Entroy=[];
for i2=1:3
    disp("------------分析信号选择------------");
    disp(['------------分析熵值时，请按照正常 外圈 内圈的顺序选择信号，目前是第 ',num2str(i2),' 次选择------------']);
    disp("------------1.振动信号（b216）  2.电流信号（b216）  3.CWRU信号  4.Paderborn信号 5.2023电流信号------------");
    i=input("------------请选择要分析的信号(1 or 2 or 3 or 4 or 5)： ");
    [data,fs,fr,~]=Choose_Signa(i);N=length(data);%加载数据
    if i~=5
%         sizex=size(data);
%         if sizex(:,2) ~= 1
%             disp(['------------当前的信号维度为：', num2str(sizex),'，其中第 1 2 3列为电压数据------------']);
%             chose_i = input("------------请选择要分析的列：");
%             data=data(:,chose_i);
%         end
        Seg_data=Segment_data(data,i);
        [Sam_en,Per_en,Fuz_en,App_en]=Entroy_code_4(Seg_data);
        A_Sam_en(i2,:)=Sam_en;B_Per_en(i2,:)=Per_en;
        C_Fuz_en(i2,:)=Fuz_en;D_App_en(i2,:)=App_en;
        if i2==3
            Entroy=[A_Sam_en;B_Per_en;C_Fuz_en;D_App_en];
            Plot_3(Entroy);
        end
    end
    if i==5
        sizex=size(data);
        if sizex(:,2) ~= 1
            disp(['------------当前的信号维度为：', num2str(sizex),'，其中第 2 4 6列为电压数据------------']);
            chose_i = input("------------请选择要分析的列：");
            data=data(:,chose_i);
        end
        Seg_data=Segment_data(data,i);
        [Sam_en,Per_en,Fuz_en,App_en]=Entroy_code_4(Seg_data);
        A_Sam_en(i2,:)=Sam_en;B_Per_en(i2,:)=Per_en;
        C_Fuz_en(i2,:)=Fuz_en;D_App_en(i2,:)=App_en;
        if i2==3
            Entroy=[A_Sam_en;B_Per_en;C_Fuz_en;D_App_en];
            Plot_3(Entroy);
        end
    end


end
