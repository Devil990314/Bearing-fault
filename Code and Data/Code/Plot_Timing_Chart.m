function Plot_Timing_Chart(data,fs,i)
sizex=size(data);
switch i
    case 1
        Plot_1(data,fs);
        sgtitle('振动信号(b216)时序图、频谱及包络谱');
    case 2
        Plot_1(data,fs);
        sgtitle('电流信号(b216)时序图、频谱及包络谱');
    case 3
        Plot_1(data,fs);
        sgtitle('CWRU轴承数据时序图、频谱及包络谱');
    case 4
        for ii=1:3
            Plot_1(data(:,ii),fs);
            switch ii
                case 1
                    sgtitle('Paderborn轴承电流信号(1)时序图、频谱及包络谱');
                case 2
                    sgtitle('Paderborn轴承电流信号(2)时序图、频谱及包络谱');
                case 3
                    sgtitle('Paderborn轴承振动信号时序图、频谱及包络谱');
                otherwise
                    disp('------------程序运行错误-Plot_Timing_Chart');
                    return
            end
        end
    case 5
        if sizex(:,2) ~= 1
            for ii=2:2:6
                Plot_1(data(:,ii),fs);
                switch ii
                    case 2
                        sgtitle('202306 B216轴承U相电流时序图、频谱及包络谱');
                    case 4
                        sgtitle('202306 B216轴承V相电流时序图、频谱及包络谱');
                    case 6
                        sgtitle('202306 B216轴承W相电流时序图、频谱及包络谱');
                    otherwise
                        disp('------------程序运行错误-Plot_Timing_Chart');
                        return
                end
            end

        end
        if sizex(:,2) == 1
            Plot_1(data,fs);
            sgtitle('202306 Current data 重构信号时序图、频谱及包络谱');
        end

    otherwise
        disp('------------程序运行错误-Plot_Timing_Chart');
end
disp("------------Plot_Timing_Chart 时序图、频谱图及包络谱图绘制完毕")
end