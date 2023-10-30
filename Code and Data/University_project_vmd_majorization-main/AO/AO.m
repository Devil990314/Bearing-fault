%% ��ӥ�Ż����㷨�Ӻ���
function [Best_P,Best_FF,Convergence_curve]=AO(signal,tau,DC,init,tol,SearchAgents_no ,Max_iteration,lb,ub,dim,fun)

% ��ʼ��AO�Ĳ�����Ϣ
Best_P=zeros(1,dim);  % ����λ��
Best_FF=inf;     % �����Ӧ��
% ��ʼ����Ⱥλ��
X=initialization(SearchAgents_no,dim,ub,lb);
Xnew=X;
% ��ʼ����Ⱥ��Ӧ������
Ffun=zeros(1,size(X,1));
Ffun_new=zeros(1,size(Xnew,1));
% ������������
alpha=0.1;
delta=0.1;
% ��ʼ������������Ϣ�Ĵ洢����
Convergence_curve=zeros(Max_iteration,1);
% ��ʼ����
for t=1:Max_iteration
    for i=1:size(X,1)
        % λ��Լ��
        F_UB=X(i,:)>ub;
        F_LB=X(i,:)<lb;
        X(i,:)=(X(i,:).*(~(F_UB+F_LB)))+ub.*F_UB+lb.*F_LB;
        % �����i���������Ӧ��
         [u, ~, ~] = VMD(signal,  round(X(i,2)), tau,  round(X(i,1)), DC, init, tol);
        for ii=1:X(i,1)%size(Positions,1)=10��ÿһ��iʱ��ѭ��Positions��һ��������x��
            bao=hilbert(u(ii,:));
            bao=abs(bao);
            p=bao./sum(bao);
            e110(ii,:)=-sum(p.*log10(p));
        end
       Ffun(1,i)=min(e110);%����ÿһ��position�ĵ÷�
        % �����Ÿ��������Ӧ�ȵıȽ�
        if Ffun(1,i)<Best_FF
            Best_FF=Ffun(1,i);
            Best_P=X(i,:);
        end
    end
    % ����㷨�����ĸ���
    G2=2*rand()-1; % Eq. (16)
    G1=2*(1-(t/Max_iteration));  % Eq. (17)
    to = 1:dim;
    u = .0265;
    r0 = 10;
    r = r0 +u*to;
    omega = .005;
    phi0 = 3*pi/2;
    phi = -omega*to+phi0;
    x = r .* sin(phi);  % Eq. (9)
    y = r .* cos(phi); % Eq. (10)
    QF=t^((2*rand()-1)/(1-Max_iteration)^2); % Eq. (15)
    %-------------------------------------------------------------------------------------
    % λ�ø��²���
    for i=1:size(X,1)
        %-------------------------------------------------------------------------------------
        if t<=(2/3)*Max_iteration
            % 1. ��չ��̽�׶�
            if rand <0.5
                Xnew(i,:)=Best_P(1,:)*(1-t/Max_iteration)+(mean(X(i,:))-Best_P(1,:))*rand(); % Eq. (3) and Eq. (4)
                Xnew(i,:) = simplebounds(Xnew(i,:),lb,ub);
                Ffun_new(1,i)=fun(Xnew(i,:));
                if Ffun_new(1,i)<Ffun(1,i)
                    X(i,:)=Xnew(i,:);
                    Ffun(1,i)=Ffun_new(1,i);
                end
            else
                % 2. ��С��̽�׶�
                %-------------------------------------------------------------------------------------
                Xnew(i,:)=Best_P(1,:).*Levy(dim)+X((floor(SearchAgents_no*rand()+1)),:)+(y-x)*rand;       % Eq. (5)
                Xnew(i,:) = simplebounds(Xnew(i,:),lb,ub);
                Ffun_new(1,i)=fun(Xnew(i,:));
                if Ffun_new(1,i)<Ffun(1,i)
                    X(i,:)=Xnew(i,:);
                    Ffun(1,i)=Ffun_new(1,i);
                end
            end
            %-------------------------------------------------------------------------------------
        else
            % 3. ���󿪷��׶�
            if rand<0.5
                Xnew(i,:)=(Best_P(1,:)-mean(X))*alpha-rand+((ub-lb)*rand+lb)*delta;   % Eq. (13)
                Xnew(i,:) = simplebounds(Xnew(i,:),lb,ub);
                Ffun_new(1,i)=fun(Xnew(i,:));
                if Ffun_new(1,i)<Ffun(1,i)
                    X(i,:)=Xnew(i,:);
                    Ffun(1,i)=Ffun_new(1,i);
                end
            else
                % 4. ��С�����׶�
                %-------------------------------------------------------------------------------------
                Xnew(i,:)=QF*Best_P(1,:)-(G2*X(i,:)*rand)-G1.*Levy(dim)+rand*G2; % Eq. (14)
                Xnew(i,:) = simplebounds(Xnew(i,:),lb,ub);
                Ffun_new(1,i)=fun(Xnew(i,:));
                if Ffun_new(1,i)<Ffun(1,i)
                    X(i,:)=Xnew(i,:);
                    Ffun(1,i)=Ffun_new(1,i);
                end
            end
        end
    end
    %-------------------------------------------------------------------------------------
    % ��¼��������
    Convergence_curve(t)=Best_FF;
end
%��������

end


