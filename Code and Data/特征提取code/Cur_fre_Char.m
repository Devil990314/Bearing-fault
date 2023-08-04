function [f_or_s1,f_or_s2,f_if_s1,f_if_s2,Amp_f_if,Amp_f_of,Amp_2f_if,Amp_2f_of] =Cur_fre_Char (fr,f,X)
    Fre_matrix=[f',abs(X')];
    x=Fre_matrix(:,1);y=Fre_matrix(:,2);

    D=39.0398;d=7.94004;a=0;Z=9;
    a=a/180*pi;%将角度转换为弧度
    F_if=Z*(1+d/D*cos(a))*fr/2;F_of=Z*(1-d/D*cos(a))*fr/2;%计算内圈、外圈故障频率
    [~,index]=min(abs(x-(fr+F_of)));f_or_s1=y(index);
    [~,index]=min(abs(x-(fr+2*F_of)));f_or_s2=y(index);
    [~,index]=min(abs(x-(fr+F_if)));f_if_s1=y(index);
    [~,index]=min(abs(x-(fr+2*F_if)));f_if_s2=y(index);
    [~,index]=min(abs(x-F_if));Amp_f_if=y(index);
    [~,index]=min(abs(x-F_of));Amp_f_of=y(index);
    [~,index]=min(abs(x-2*F_if));Amp_2f_if=y(index);
    [~,index]=min(abs(x-2*F_of));Amp_2f_of=y(index);
end