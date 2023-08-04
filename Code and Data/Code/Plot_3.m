function Plot_3(Entroy)

        % 假设你的矩阵名为 data
        % 选择保存路径和文件名
        [file,path] = uiputfile('*.xls','Save file name');
        if isequal(file,0)
            disp('------------User selected Cancel------------')
        else
            disp(['------------矩阵Entroy保存路径------------ ', fullfile(path,file)])
            % 将矩阵 data 写入 Excel 文件中
            fullpath = fullfile(path,file);
            xlswrite(fullpath,[Entroy, NaN(size(Entroy,1),1)]);
        end
        figure;t=1:10;
        Title_1=input('请输入图标题： ','s');sgtitle(Title_1)
        subplot(221);
        plot(t,Entroy(1,:), 'LineWidth', 2, 'LineStyle', '-', 'Color', [0.5 0.5 0.5], 'Marker', 'o', 'MarkerSize', 6, 'DisplayName', '正常信号');
        hold on;
        plot(t,Entroy(2,:), 'LineWidth', 2, 'LineStyle', '--', 'Color', [0.2 0.5 0.2], 'Marker', '*', 'MarkerSize', 8, 'DisplayName', '外圈故障');
        plot(t,Entroy(3,:), 'LineWidth', 2, 'LineStyle', ':', 'Color', [0.8 0.3 0.2], 'Marker', '+', 'MarkerSize', 7, 'DisplayName', '内圈故障');
        legend;title('样本熵');grid on;

        subplot(222);
        plot(t,Entroy(4,:), 'LineWidth', 2, 'LineStyle', '-', 'Color', [0.5 0.5 0.5], 'Marker', 'o', 'MarkerSize', 6, 'DisplayName', '正常信号');
        hold on;
        plot(t,Entroy(5,:), 'LineWidth', 2, 'LineStyle', '--', 'Color', [0.2 0.5 0.2], 'Marker', '*', 'MarkerSize', 8, 'DisplayName', '外圈故障');
        plot(t,Entroy(6,:), 'LineWidth', 2, 'LineStyle', ':', 'Color', [0.8 0.3 0.2], 'Marker', '+', 'MarkerSize', 7, 'DisplayName', '内圈故障');
        legend;title('排列熵');grid on;


        subplot(223);
        plot(t,Entroy(7,:), 'LineWidth', 2, 'LineStyle', '-', 'Color', [0.5 0.5 0.5], 'Marker', 'o', 'MarkerSize', 6, 'DisplayName', '正常信号');
        hold on;
        plot(t,Entroy(8,:), 'LineWidth', 2, 'LineStyle', '--', 'Color', [0.2 0.5 0.2], 'Marker', '*', 'MarkerSize', 8, 'DisplayName', '外圈故障');
        plot(t,Entroy(9,:), 'LineWidth', 2, 'LineStyle', ':', 'Color', [0.8 0.3 0.2], 'Marker', '+', 'MarkerSize', 7, 'DisplayName', '内圈故障');
        legend;title('模糊熵');grid on;

        subplot(224);
        plot(t,Entroy(10,:), 'LineWidth', 2, 'LineStyle', '-', 'Color', [0.5 0.5 0.5], 'Marker', 'o', 'MarkerSize', 6, 'DisplayName', '正常信号');
        hold on;
        plot(t,Entroy(11,:), 'LineWidth', 2, 'LineStyle', '--', 'Color', [0.2 0.5 0.2], 'Marker', '*', 'MarkerSize', 8, 'DisplayName', '外圈故障');
        plot(t,Entroy(12,:), 'LineWidth', 2, 'LineStyle', ':', 'Color', [0.8 0.3 0.2], 'Marker', '+', 'MarkerSize', 7, 'DisplayName', '内圈故障');
        legend;title('近似熵');grid on;
        
        
%% 
        figure;
        subplot(221);
        plot(t,10*log10(Entroy(1,:)), 'LineWidth', 2, 'LineStyle', '-', 'Color', [0.5 0.5 0.5], 'Marker', 'o', 'MarkerSize', 6, 'DisplayName', '正常信号');
        hold on;
        plot(t,10*log10(Entroy(2,:)), 'LineWidth', 2, 'LineStyle', '--', 'Color', [0.2 0.5 0.2], 'Marker', '*', 'MarkerSize', 8, 'DisplayName', '外圈故障');
        plot(t,10*log10(Entroy(3,:)), 'LineWidth', 2, 'LineStyle', ':', 'Color', [0.8 0.3 0.2], 'Marker', '+', 'MarkerSize', 7, 'DisplayName', '内圈故障');
        legend;title('样本熵');grid on;
        subplot(222);
        plot(t,10*log10(Entroy(4,:)), 'LineWidth', 2, 'LineStyle', '-', 'Color', [0.5 0.5 0.5], 'Marker', 'o', 'MarkerSize', 6, 'DisplayName', '正常信号');
        hold on;
        plot(t,10*log10(Entroy(5,:)), 'LineWidth', 2, 'LineStyle', '--', 'Color', [0.2 0.5 0.2], 'Marker', '*', 'MarkerSize', 8, 'DisplayName', '外圈故障');
        plot(t,10*log10(Entroy(6,:)), 'LineWidth', 2, 'LineStyle', ':', 'Color', [0.8 0.3 0.2], 'Marker', '+', 'MarkerSize', 7, 'DisplayName', '内圈故障');
        legend;title('排列熵');grid on;


        subplot(223);
        plot(t,10*log10(Entroy(7,:)), 'LineWidth', 2, 'LineStyle', '-', 'Color', [0.5 0.5 0.5], 'Marker', 'o', 'MarkerSize', 6, 'DisplayName', '正常信号');
        hold on;
        plot(t,10*log10(Entroy(8,:)), 'LineWidth', 2, 'LineStyle', '--', 'Color', [0.2 0.5 0.2], 'Marker', '*', 'MarkerSize', 8, 'DisplayName', '外圈故障');
        plot(t,10*log10(Entroy(9,:)), 'LineWidth', 2, 'LineStyle', ':', 'Color', [0.8 0.3 0.2], 'Marker', '+', 'MarkerSize', 7, 'DisplayName', '内圈故障');
        legend;title('模糊熵');grid on;

        subplot(224);
        plot(t,10*log10(Entroy(10,:)), 'LineWidth', 2, 'LineStyle', '-', 'Color', [0.5 0.5 0.5], 'Marker', 'o', 'MarkerSize', 6, 'DisplayName', '正常信号');
        hold on;
        plot(t,10*log10(Entroy(11,:)), 'LineWidth', 2, 'LineStyle', '--', 'Color', [0.2 0.5 0.2], 'Marker', '*', 'MarkerSize', 8, 'DisplayName', '外圈故障');
        plot(t,10*log10(Entroy(12,:)), 'LineWidth', 2, 'LineStyle', ':', 'Color', [0.8 0.3 0.2], 'Marker', '+', 'MarkerSize', 7, 'DisplayName', '内圈故障');
        legend;title('近似熵');grid on;sgtitle(Title_1)
        end