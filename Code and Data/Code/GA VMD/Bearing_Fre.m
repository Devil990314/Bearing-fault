function f=Bearing_Fre(i,fr)
switch i
    case 6205
        %D为轴承节径，d为滚动体直径，a为接触角，角度，Z为滚动体数目,Fr为转速
        D=39.0398;d=7.94004;a=0;%根据不同轴承类型而定
        Z=9;a=a/180*pi;%将角度转换为弧度
        %fr=input("请输入转速： ");
        fr=fr/60;%将转速转换为转频
        Fic=Z*(1+d/D*cos(a))*fr/2;disp(['------------6205轴承内圈故障频率：Fic=',num2str(Fic)])
        Foc=Z*(1-d/D*cos(a))*fr/2;disp(['------------6205轴承外圈故障频率：Foc=',num2str(Foc)])
        Fbc=D*(1-(d/D*cos(a))^2)*fr/d/2;
        disp(['------------6205轴承滚动体故障频率：Fbc=',num2str(Fbc)])
        Fcc=(1-d/D*cos(a))*fr/2;
        disp(['------------6205轴承保持架故障频率：Fc=',num2str(Fcc)])
        disp(['------------该工况下转频：fr_fre=',num2str(fr)]);
        assignin('base', 'fr_fre', fr);
        ii=input("------------请选择本次数据的故障类型：1.内圈 2.外圈 3.滚动体 4.保持架 5.正常------------ ");
        switch ii
            case 1
                f = Fic;
                assignin('base', 'Fic', f);
            case 2
                f =Foc;
                assignin('base', 'Foc', f);
            case 3
                f =Fbc;
                assignin('base', 'Fbc', f);
            case 4
                f =Fcc;
                assignin('base', 'Fcc', f);
            case 5
                f =0;
            otherwise
                disp("------------输出错误！")
        end

    case 6203
        %D为轴承节径，d为滚动体直径，a为接触角，角度，Z为滚动体数目,Fr为转速
        Di=33.1;Do=24.0;D=(Di+Do)/2;d=6.75;a=0;%根据不同轴承类型而定
        Z=8;a=a/180*pi;%将角度转换为弧度
        %fr=input("请输入转速：");
        fr=fr/60;%将转速转换为转频
        Fic=Z*(1+d/D*cos(a))*fr/2;disp(['------------6203轴承内圈故障频率：Fic=',num2str(Fic)])
        Foc=Z*(1-d/D*cos(a))*fr/2;disp(['------------6203外圈故障频率：Foc=',num2str(Foc)])
        Fbc=D*(1-(d/D*cos(a))^2)*fr/d/2;
        disp(['------------6203滚动体故障频率：Fbc=',num2str(Fbc)])
        Fcc=(1-d/D*cos(a))*fr/2;
        disp(['------------6203保持架故障频率：Fc=',num2str(Fcc)])
        disp(['------------该工况下转频：fr_fre=',num2str(fr)]);
        ii=input("------------请选择本次数据的故障类型：1.内圈 2.外圈 3.滚动体 4.保持架 5.正常------------ ");
        switch ii
            case 1
                f = Fic;
                assignin('base', 'Fic', f);
            case 2
                f =Foc;
                assignin('base', 'Foc', f);
            case 3
                f =Fbc;
                assignin('base', 'Fbc', f);
            case 4
                f =Fcc;
                assignin('base', 'Fcc', f);
            case 5
                f =0;
            otherwise
                disp("------------输出错误！")
        end
    otherwise
        disp("------------输入错误，未计算轴承特征频率！")
end
end