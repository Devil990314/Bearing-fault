%% 天鹰优化器算法子函数
function [Best_P,Best_FF,Convergence_curve]=AO(signal,tau,DC,init,tol,SearchAgents_no ,Max_iteration,lb,ub,dim,fun)

% 初始化AO的参数信息
Best_P=zeros(1,dim);  % 最优位置
Best_FF=inf;     % 最佳适应度
% 初始化种群位置
X=initialization(SearchAgents_no,dim,ub,lb);
Xnew=X;
% 初始化种群适应度数组
Ffun=zeros(1,size(X,1));
Ffun_new=zeros(1,size(Xnew,1));
% 开发调整参数
alpha=0.1;
delta=0.1;
% 初始化进化参数信息的存储数组
Convergence_curve=zeros(Max_iteration,1);
% 开始进化
for t=1:Max_iteration
    for i=1:size(X,1)
        % 位置约束
        F_UB=X(i,:)>ub;
        F_LB=X(i,:)<lb;
        X(i,:)=(X(i,:).*(~(F_UB+F_LB)))+ub.*F_UB+lb.*F_LB;
        % 计算第i个个体的适应度
         [u, ~, ~] = VMD(signal,  round(X(i,2)), tau,  round(X(i,1)), DC, init, tol);
        for ii=1:X(i,1)%size(Positions,1)=10，每一个i时，循环Positions第一个参数的x次
            bao=hilbert(u(ii,:));
            bao=abs(bao);
            p=bao./sum(bao);
            e110(ii,:)=-sum(p.*log10(p));
        end
       Ffun(1,i)=min(e110);%计算每一个position的得分
        % 与最优个体进行适应度的比较
        if Ffun(1,i)<Best_FF
            Best_FF=Ffun(1,i);
            Best_P=X(i,:);
        end
    end
    % 相关算法参数的更新
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
    % 位置更新策略
    for i=1:size(X,1)
        %-------------------------------------------------------------------------------------
        if t<=(2/3)*Max_iteration
            % 1. 扩展勘探阶段
            if rand <0.5
                Xnew(i,:)=Best_P(1,:)*(1-t/Max_iteration)+(mean(X(i,:))-Best_P(1,:))*rand(); % Eq. (3) and Eq. (4)
                Xnew(i,:) = simplebounds(Xnew(i,:),lb,ub);
                Ffun_new(1,i)=fun(Xnew(i,:));
                if Ffun_new(1,i)<Ffun(1,i)
                    X(i,:)=Xnew(i,:);
                    Ffun(1,i)=Ffun_new(1,i);
                end
            else
                % 2. 缩小勘探阶段
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
            % 3. 扩大开发阶段
            if rand<0.5
                Xnew(i,:)=(Best_P(1,:)-mean(X))*alpha-rand+((ub-lb)*rand+lb)*delta;   % Eq. (13)
                Xnew(i,:) = simplebounds(Xnew(i,:),lb,ub);
                Ffun_new(1,i)=fun(Xnew(i,:));
                if Ffun_new(1,i)<Ffun(1,i)
                    X(i,:)=Xnew(i,:);
                    Ffun(1,i)=Ffun_new(1,i);
                end
            else
                % 4. 缩小开发阶段
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
    % 记录进化过程
    Convergence_curve(t)=Best_FF;
end
%进化结束

end



