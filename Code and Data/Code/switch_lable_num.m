function Sample_label=switch_lable_num(label_num)
switch label_num
    case 0
        %Sample_label='Nom';
        disp('此样本标签为：Nom')
        Sample_label=0;
    case 1
        %Sample_label='IR';
        disp('此样本标签为：IR')
        Sample_label=1;
    case 2
        %Sample_label='OR';
        disp('此样本标签为：OR')
        Sample_label=2;
    otherwise
        disp('输入错误，请重新输入！')
        label_num=input('请输入数据标签 0 or 1 or 2 ：');
        disp('0.Norm    1.IR     2.OR');
        switch label_num
            case 0
                %Sample_label='Nom';
                disp('此样本标签为：Nom')
            case 1
                %Sample_label='OR';
                disp('此样本标签为：IR')
            case 2
                %Sample_label='IR';
                disp('此样本标签为：OR')
                %Sample_label='IR';
                disp('此样本为内圈故障数据')
            otherwise
                disp('输入错误，请重新输入！')
        end
end

end