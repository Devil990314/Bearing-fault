function net = cnntrain(net, x, y)
% CNN����,ѵ��

m = size(x, 3);                                                 % ѵ����������
numbatches = ceil(m / net.batchsize);                           % "ѵ�����������һ��"����Ȩֵ���µĴ���

net.ERR = zeros(1,net.epochs);
% net.ERR = [];

for I = 1 : net.epochs                                          % ��ѵ�����������������ѭ��
    
    disp(['epoch ' num2str(I) '/' num2str(net.epochs)]);        % ��ʾ����
    tic;
    
    kk = randperm(m);                                           % ����ѵ������˳��
    
    %----------------------------------------------------------------------
    % ��"ѵ�����������һ��"����Ȩֵ���µĴ�����ѭ��
    
    mse = 0;
    for L = 1 : numbatches                                      % ����ѵ��һ��������µĴ���
        
        % ȡ������˳����batchsize�������Ͷ�Ӧ�ı�ǩ
        batch_x = x(:, :, kk((L - 1) * net.batchsize + 1 : min(L * net.batchsize, m)));
        batch_y = y(:,    kk((L - 1) * net.batchsize + 1 : min(L * net.batchsize, m)));
        
        % �ڵ�ǰ������Ȩֵ�����������¼�����������(�������)
        net = cnnff(net, batch_x);                              % CNN�������(�������㷨,������convn�÷�,�����������ӳ��)
        
        % �õ���������������ͨ����Ӧ��������ǩ��bp�㷨���õ���������Ȩֵ(���򴫲�)
        net = cnnbp(net, batch_y);
        
        % �õ�����Ȩֵ�ĵ����󣬾�ͨ��Ȩֵ���·���ȥ����Ȩֵ
        net = cnnupdate(net);
        
        mse = mse+net.err;
%         if isempty(net.ERR)
%             net.ERR(1) = net.err;                                       % ���ۺ���ֵ��Ҳ�������ֵ
%         end
%         net.ERR(end + 1) = 0.99 * net.ERR(end) + 0.01 * net.err;        % ������ʷ�����ֵ���Ա㻭ͼ����
    end
    mse = mse / numbatches
%     mse = net.ERR(end)
    
    net.ERR(I) = mse;
    
    %----------------------------------------------------------------------
    
    toc;
end

%==========================================================================

end
