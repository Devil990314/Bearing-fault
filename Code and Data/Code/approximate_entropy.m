function ApEn = approximate_entropy(x,m,r)

% 计算输入信号x的近似熵(ApEn)
% m：嵌入维度(embedding dimension)
% r：判据阈值(threshold for the criterion)

N = length(x);
phi = zeros(1,2); % 初始化两个Phi值

for k = 1:2 % 对于m和m+1做两次运算
    m_new = m+k-1;
    Ck = zeros(1,N-m_new+1); % 用于存储每个向量的距离计数
    % 在第 12 行之后添加以下代码
    disp(size(x))
    disp(size(x(i:N-m_new+i-1)))
    % 计算所有可能的m_new长度向量之间的欧几里得距离
    for i = 1:N-m_new+1
        temp = repmat(x(i:i+m_new-1),N-m_new+1,1);
        Ck(i) = sum(sqrt(sum((temp - x(i:N-m_new+i-1)).^2,2)) <= r)/(N-m_new+1);
    end
    
    phi(k) = (N-m_new+1)^(-1)*sum(log(Ck)); % 计算Phi值
end

ApEn = phi(1) - phi(2); % 返回近似熵(ApEn)值

end