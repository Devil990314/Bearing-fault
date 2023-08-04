function f=Chose_Fault_Type(Fic,Foc,Fcc,Fbc)
i=input("------------请选择本次数据的故障类型：1.内圈 2.外圈 3.滚动体 4.保持架 5.忽略------------ ");
switch i
    case 1
        f = Fic;
    case 2
        f =Foc;
    case 3
        f =Fbc;
    case 4
        f =Fcc;
    case 5
        f = 0;
    otherwise
        disp("------------输出错误！")
end

end