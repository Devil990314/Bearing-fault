function [x_1,x_2]=pre_by_lya_new(m,lmd,whlsj,whlsl,P,idx)
% m=7;
% imd=0.144076;
% data=load('f:\wuyouli\data\bk.txt');
% whlsj=data(:,4);
% [lll,whlsl]=size(whlsj);
% global a Y ind
for j=1:(whlsl-m+1)            %��ռ��ع�
    for i=1:m
        Y(i,j)=whlsj(i+j-1);
    end
end

%******************************************************
% min_d=1e+100;
% for jj=1:(whlsl-m)          %����С�����
%     sum_d=0.;
%     for ii=1:m
%        sum_d=sum_d+(Y(ii,jj)-Y(ii,whlsl-m+1))^2;
%     end
%     d(jj)=sum_d;
%     if (min_d>d(jj))&(d(jj) > 0)
%         min_d=d(jj);
%         idx=jj;
%     end
% end
%**********************������Ǻ�Ѱ�����ĵ�Ľ������********************************
% *�ɵ�����
%P = 5  ; %  &&ѡ���ݻ����൱ǰ���λ�ò������ǰ���ΪI�����ݻ����ֻ����|I��J|<P���������Ѱ
min_point=1  ; %&&Ҫ�������������ĵ���
MAX_CISHU=5 ;  %&&�������������Χ����
% global lmd;
% min_m = 2;
% max_m = 10;
% data=load('f:\wuyouli\whl_program\bk.txt');%��ȡ����
% whlsj=data(:,4);
% [whlsl,lllll]=size(whlsj);
% *   mΪǶ��ά��

%     * �������С��ƽ��������
max_d = 0;
min_d = 1.0e+100;
avg_d = 0;
for i = 1 : whlsl-m
    avg_dd = 0;
    for j = i+1 : whlsl-m+1
        d = 0;
        for k = 1 : m
            d = d + (whlsj(i+k-1)-whlsj(j+k-1))*(whlsj(i+k-1)-whlsj(j+k-1));
        end
        d = sqrt(d);
        if max_d < d
            max_d = d;
        end
        if min_d > d
            min_d = d;
        end
        avg_dd = avg_dd + d;
    end
    avg_dd = avg_dd/(whlsl-m+1-i-1+1);
    avg_d = avg_d + avg_dd;
end
avg_d = avg_d/(whlsl-m);

dlt_eps = (avg_d - min_d) * 0.02 ;         %&&����min_eps��max_eps���Ҳ����ݻ����ʱ����max_eps�Ŀ������
min_eps = min_d + dlt_eps / 2 ;               %&&�ݻ�����뵱ǰ���������С��
max_eps = min_d + 2 * dlt_eps  ;           %&&�ݻ�����뵱ǰ������������

%     *��1��whlsl-m+1-P-1��������������ĵ��ǰһ����������������λ��(Loc_DK)������̾���DK
DK = 1.0e+100;
for jj=1:(whlsl-m)          %����С�����
    sum_d=0.;
    for ii=1:m
        sum_d=sum_d+(Y(ii,jj)-Y(ii,whlsl-m+1))^2;
    end
    d(jj)=sum_d;
    if (min_d>d(jj))&(d(jj) > 0)
        DK=d(jj);
        Loc_DK=jj;
    end
end

%     * i Ϊ�����ţ���1��(whlsl-m)��Ҳ��i-1����ݻ��㣻Loc_DKΪ���i-1��Ӧ��̾�������λ�ã�DKΪ���Ӧ����̾���
%     * Loc_DK+1ΪLoc_DK���ݻ��㣬DK1Ϊi�㵽Loc_DK+1��ľ��룬��Ϊ�ݻ�����
%     * ǰi��log2��DK1/DK�����ۼƺ�������i���lamdaֵ
sum_lmd = 0 ;   %&&���ǰi��log2��DK1/DK�����ۼƺ�
for i = 2 : whlsl-m
    % * �����ݻ�����
    DK1 = 0;
    for k = 1 : m
        DK1 = DK1 + (whlsj(i+k-1)-whlsj(Loc_DK+1+k-1))*(whlsj(i+k-1)-whlsj(Loc_DK+1+k-1));
    end
    DK1 = sqrt(DK1);
    old_Loc_DK = Loc_DK ;    %&&����Դ�����λ�����
    old_DK=DK;

    %         * ����ǰi��log2��DK1/DK�����ۼƺ��Լ�����i�������ָ��
    if (DK1 ~= 0)&( DK ~= 0)
        sum_lmd = sum_lmd + log(DK1/DK) /log(2);
    end
    lmd(i-1) = sum_lmd/(i-1);
    max_eps = min_d + 2 * dlt_eps ;            %&&�ݻ�����뵱ǰ������������
    %         *����Ѱ��i�����̾��룺Ҫ�������ָ�����뷶Χ�ھ����̣���DK1�ĽǶ���С
    point_num = 0  ; % &&��ָ�����뷶Χ���ҵ��ĺ�ѡ���ĸ���
    cos_sita = 0  ; %&&�н����ҵıȽϳ�ֵ ����Ҫ��һ�������
    zjfwcs=0     ;%&&���ӷ�Χ����
    while (point_num == 0)
        % * �������
        for j = 1 : whlsl-m
            if abs(j-i) <=(P-1)      %&&��ѡ��൱ǰ��̫����������
                continue;
            end

            %*�����ѡ���뵱ǰ��ľ���
            dnew = 0;
            for k = 1 : m
                dnew = dnew + (whlsj(i+k-1)-whlsj(j+k-1))*(whlsj(i+k-1)-whlsj(j+k-1));
            end
            dnew = sqrt(dnew);

            if (dnew < min_eps)|( dnew > max_eps )   %&&���ھ��뷶Χ��������
                continue;
            end


            %*����н����Ҽ��Ƚ�
            DOT = 0;
            for k = 1 : m
                DOT = DOT+(whlsj(i+k-1)-whlsj(j+k-1))*(whlsj(i+k-1)-whlsj(old_Loc_DK+1+k-1));
            end
            CTH = DOT/(dnew*DK1);

            if acos(CTH) > (3.14151926/4)      %&&����С��45�ȵĽǣ�������
                continue;
            end

            if CTH > cos_sita   %&&�¼н�С�ڹ�ȥ���ҵ������ļнǣ�����
                cos_sita = CTH;
                Loc_DK = j;
                DK = dnew;
            end

            point_num = point_num +1;

        end

        if point_num <= min_point
            max_eps = max_eps + dlt_eps;
            zjfwcs =zjfwcs +1;
            if zjfwcs > MAX_CISHU    %&&�������ſ��������������ĵ�
                DK = 1.0e+100;
                for ii = 1 : whlsl-m
                    if abs(i-ii) <= P-1      %&&��ѡ��൱ǰ��̫����������
                        continue;
                    end
                    d = 0;
                    for k = 1 : m
                        d = d + (whlsj(i+k-1)-whlsj(ii+k-1))*(whlsj(i+k-1)-whlsj(ii+k-1));
                    end
                    d = sqrt(d);

                    if (d < DK) & (d > min_eps)
                        DK = d;
                        Loc_DK = ii;
                    end
                end
                break
            end
            point_num = 0          ;     %&&������뷶Χ��������
            cos_sita = 0;
        end
    end
end

%     * ������˼����������ŵ��ָ��lmd_m(m)
lmd_m(m) = 0;
for i=(whlsl-m-50):1:(whlsl-m-1)
    lmd_m(m) = lmd_m(m) + lmd(i);
end
lmd_m(m) = lmd_m(m)/50;        %&&(whlsl-m-zero_num(m))






%*******************************************************
a_1=0;
for k=1:(m-1)
    a_1=a_1+(Y(k,idx+1)-whlsj(whlsl-m+1+k))*(Y(k,idx+1)-whlsj(whlsl-m+1+k));
end
  deta=sqrt((min_d^2)*(2.718^(lmd*2))-a_1);
%deta=sqrt(min_d*2^(2*lmd)-a_1);
x_1=Y(m,idx+1)+deta;
x_2=Y(m,idx+1)-deta;
