function [Sam_en,Per_en,Fuz_en,App_en]=Entroy_code_4(Seg_data)
Sam_en=[];Per_en=[];Fuz_en=[];App_en=[];
disp('------------开始计算熵值------------');
parfor i=1:size(Seg_data,1)
    tic;
    Seg_data_i=Seg_data(i,:);
    disp(['------------正在进行第 ',num2str(i),' 个样本的熵值计算------------']);
    
    %样本熵
    dim=2;r=0.2*std(Seg_data_i);Sam_en(1,i) = SampleEntropy( dim, r, Seg_data_i);

    % 排列熵 延迟时间1 % 嵌入维数 可以选择3-10，嵌入维数越大，时间越长
    M=3;T=1;Per_en(1,i)= PermutationEntropy(Seg_data_i,M,T);

    %模糊熵 r为相似容限度
    eDim=2;r0=0.15*std(Seg_data_i);Fuz_en(1,i) = FuzzyEntropy(Seg_data_i,eDim,r0,2,1);
    
    %近似熵
    App_en(1,i)=approximateEntropy(Seg_data_i,1,2);
    toc;
end

end