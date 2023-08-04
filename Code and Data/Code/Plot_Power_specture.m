function Plot_Power_specture(data,fs,i)
sizex=size(data);
switch i
    case 1
        Plot_2(data,fs);
        sgtitle('振动信号(b216)功率谱图');
    case 2
        Plot_2(data,fs);
        sgtitle('电流信号(b216)功率谱图');
    case 3
        Plot_2(data,fs);
        sgtitle('CWRU轴承数据功率谱图');
    case 4
        for ii=1:3
            Plot_2(data(:,ii),fs);
            switch ii
                case 1
                    sgtitle('Paderborn轴承电流信号(1)功率谱图');
                case 2
                    sgtitle('Paderborn轴承电流信号(2)功率谱图');
                case 3
                    sgtitle('Paderborn轴承振动信号(3)功率谱图');
                otherwise
                    disp('------------程序运行错误-Plot_Power_specture-case 4');
                    return
            end
        end
    case 5
        if sizex(:,2) == 1
            Plot_2(data,fs);
            sgtitle('202306 Current data 重构信号电流功率谱图');
        end
        if sizex(:,2) ~= 1
            for ii=2:2:6
                Plot_2(data(:,ii),fs);
                switch ii
                    case 2
                        sgtitle('202306 B216轴承U相电流功率谱图');
                    case 4
                        sgtitle('202306 B216轴承V相电流功率谱图');
                    case 6
                        sgtitle('202306 B216轴承W相电流功率谱图');
                    otherwise
                        disp('------------程序运行错误-Plot_Timing_Chart-case 5');
                        return
                end
            end
        end

    otherwise
        disp('-------------Plot_Power_specture');
end
disp("------------Plot_Power_specture(data,fs,i)功率谱图绘制完毕")
end