%skyhawk#flyinghawk
%�������һ�������������λ�ü���̾���
function [idx,min_d,idx1,min_d1]=nearest_point(tau,m,whlsj,whlsl,P)
%����˵����
%���룺m - Ƕ��ά���� whlsj �� ���������ݣ� whlsl - �����������ݸ����� P - ƽ��ѭ������
%      idx - ���һ�������������λ�ã� min_d - ���һ����������������ľ��� (�������)
%      idx1 - ���һ�������������λ�ã� min_d1 - ���һ����������������ľ��� (���������)
% *�ɵ�����
% P = 5  ; %  &&ѡ���ݻ����൱ǰ���λ�ò������ǰ���ΪI�����ݻ����ֻ����|I��J|<P���������Ѱ
min_point=5  ; %&&Ҫ�������������ĵ���
MAX_CISHU=5 ;  %&&�������������Χ����
% global lmd;

% ��ռ��ع�
LAST_POINT = whlsl-(m-1)*tau;  %������
for j=1:LAST_POINT            
    for k=1:m
        Y(k,j)=whlsj((k-1)*tau+j);
    end
end

% �������С��ƽ��������
max_d = 0.;
min_d = 1.0e+100;
avg_d = 0.;
for i = 1 : LAST_POINT-1
    avg_dd = 0.;
    for j = i+1 : LAST_POINT
        d = 0.;
        for k = 1 : m
            d = d + (Y(k,i)-Y(k,j))*(Y(k,i)-Y(k,j));
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
    avg_dd = avg_dd/(LAST_POINT-i-1+1);
    avg_d = avg_d + avg_dd;
end
avg_d = avg_d/(LAST_POINT-1);
  
dlt_eps = (avg_d - min_d) * 0.08 ;         % ����min_eps��max_eps���Ҳ����ݻ����ʱ����max_eps�Ŀ������
min_eps = min_d + dlt_eps / 8 ;            % �ݻ�����뵱ǰ���������С��
max_eps = min_d + 2 * dlt_eps  ;           % �ݻ�����뵱ǰ������������
    
% ��P��N-m������������һ�������������λ��(Loc_DK)������̾���DK
DK = 1.0e+100;
Loc_DK = LAST_POINT-P;
for i = 1 : LAST_POINT-P
    d = 0.;
    for k = 1 : m
        d = d + (Y(k,i)-Y(k,LAST_POINT-1))*(Y(k,i)-Y(k,LAST_POINT-1));
    end
    d = sqrt(d);
        
    if (d < DK) & (d > min_eps) 
        DK = d;
        Loc_DK = i;
    end
end

DK1 = 0.;
for k = 1 : m
    DK1 = DK1 + (Y(k,LAST_POINT)-Y(k,Loc_DK+1))*(Y(k,LAST_POINT)-Y(k,Loc_DK+1));
end
DK1 = sqrt(DK1);

old_Loc_DK=Loc_DK;
  
% ���³���������һ��������������  ��������ǣ���Ҫ�������ָ�����뷶Χ�ھ����̣���DK1�ĽǶ���С

max_eps = min_d + 2 * dlt_eps ;            % �ݻ�����뵱ǰ������������

point_num = 0  ; % ��ָ�����뷶Χ���ҵ��ĺ�ѡ���ĸ���
cos_sita = 0.  ; % �н����ҵıȽϳ�ֵ ����Ҫ��һ�������
zjfwcs=0       ; % ���ӷ�Χ����
        
while (point_num == 0)
    % �������
    for j = 1 : LAST_POINT-1
        if abs(j-LAST_POINT) <=( P-1)      % ��ѡ��൱ǰ��̫����������
           continue;      
        end
                
        % �����ѡ���뵱ǰ��ľ���
        dnew = 0.;
        for k = 1 : m
            dnew = dnew + (Y(k,LAST_POINT)-Y(k,j))*(Y(k,LAST_POINT)-Y(k,j));
        end
        dnew = sqrt(dnew);
                
        if (dnew < min_eps)|( dnew > max_eps )   % ���ھ��뷶Χ��������
           continue;              
        end                
                
        % ����н����Ҽ��Ƚ�
        DOT = 0.;
        for k = 1 : m
            DOT = DOT+(Y(k,LAST_POINT)-Y(k,j))*(Y(k,LAST_POINT)-Y(k,old_Loc_DK+1));
        end
        CTH = DOT/(dnew*DK1);
                
        if acos(CTH) > (3.14151926/4)      % ����С��45�ȵĽǣ�������
           continue;
        end
                
        if CTH > cos_sita   % �¼н�С�ڹ�ȥ���ҵ������ļнǣ�����
            cos_sita = CTH;
            Loc_DK = j;
            DK = dnew;
        end
        point_num = point_num +1;
    end  % end of for j = 1 : LAST_POINT-1     
        
    if point_num < min_point
        point_num = 0          ;     %&&������뷶Χ��������
        cos_sita = 0.;
        max_eps = max_eps + dlt_eps;
        zjfwcs =zjfwcs +1;
        if zjfwcs > MAX_CISHU    %&&�������ſ��������������ĵ�
           DK = 1.0e+100;
           for ii = 1 : LAST_POINT-1
               if abs(LAST_POINT-ii) <= P-1      %&&��ѡ��൱ǰ��̫����������
                   continue;     
               end
               d = 0.;
               for k = 1 : m
                   d = d + (Y(k,LAST_POINT)-Y(k,ii))*(Y(k,LAST_POINT)-Y(k,ii));
               end
               d = sqrt(d);
        
               if (d < DK) & (d > min_eps) 
                   DK = d;
                   Loc_DK = ii;
               end
           end  % end of for ii = 1 : LAST_POINT-1
           break  
        end %end of if zjfwcs > MAX_CISHU
    end %end of if point_num <= min_point
end  % end of while (point_num == 0)
idx=Loc_DK;  %�������ĵ��������λ��
min_d=DK;    %�������ĵ㵽��������ľ���
point_num;
% ���³���������һ��������������  ����������ǣ�
 
% ����С�����
min_d1 = 1e+100;
idx1 = LAST_POINT-1;

for jj = 1:LAST_POINT-1         

    if abs(jj-LAST_POINT) <=( P-1)      % ��ѡ��൱ǰ��̫����������
       continue;      
    end

    sum_d=0.;
    for k=1:m
       sum_d = sum_d+(Y(k,jj)-Y(k,LAST_POINT))^2;
    end
    sum_d = sqrt(sum_d);
    
    if (min_d1 > sum_d)&(sum_d > 0)
        min_d1 = sum_d;
        idx1 = jj;
    end
end
