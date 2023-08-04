function D=GP_Algorithm(data,tau,max_m)
% GP�㷨�����ά��Ƕ��ά
%clc
%---------------------------------------------------
x=data;
X = normalize_1(x);

%---------------------------------------------------'

disp('----- GP�㷨�����ά��Ƕ��ά -----');

% t = 1;
m_vector = 1:max_m;
r_vector = exp(-5:0.25:1);

num_m = length(m_vector);
num_r = length(r_vector);
ln_Cr = zeros(num_m,num_r);

%------------------------------------------------------
% tic
type_norm = 2;       % ʹ�÷������� (ȱʡֵΪ2)
                    % type_norm = 0,1,2ʱ���ֱ��Ӧ�������1������2����
block = 1;           % �ֿ�Ƽ���������� - �ֿ��� (ȱʡֵΪ1)
                    % tԽ���ٶ�Խ�죬�������
for i = 1:num_m
    i
    for j = 1:num_r
        % �����������S(m,N,r,t), �μ� <<����ʱ�����з�����Ӧ��>> P35 ʽ(2.29)
        m = m_vector(i);
        r = r_vector(j);
        %ln_Cr(i,j) = log(CorrelationIntegral(m,X,r,t)); % ȱʡ�÷�
        ln_Cr(i,j) = log(CorrelationIntegral(m,X,r,tau,type_norm,block)); 
    end
end
% t = toc
subplot(211)
ln_r = log(r_vector);
plot(ln_r,ln_Cr','+:');grid;
xlabel('ln(r)'); ylabel('ln(C(r))');
title(['norm = ',num2str(type_norm),', block = ',num2str(block),', t = ',num2str(tau)]);
legend('m=2','m=3','m=4','m=5',4)
subplot(212)
 %------------------------------------------------------
    % �����������
for i=1:num_m
   A=find(ln_Cr(i,:)~=-inf);
   t=A(1);
    LinearZone = [t:t+7];
    F = polyfit(ln_r(LinearZone),ln_Cr(i,LinearZone),1);
    D(i) = F(1);
end
 plot(D,'+:'); grid;