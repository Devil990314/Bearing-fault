function [er, bad] = cnntest2(net, x, y)
% CNN����,����(C���з��)

m = size(x, 3);                                                 % ѵ����������
h = zeros(1,m);
a = zeros(1,m);

for I = 1 : m
    
    net = cnnff2(net, x(:,:,I));                                                % ǰ�򴫲��õ����
    
    % [Y,I] = max(X) returns the indices of the maximum values in vector I
    [~, h(I)] = max(net.Y);                                                % �ҵ����������Ӧ�ı�ǩ
    
    [~, a(I)] = max(y(:,I));                                          % �ҵ��������������Ӧ������
    
end

bad = find(h ~= a);                                                 % �ҵ����ǲ���ͬ�ĸ�����Ҳ���Ǵ���Ĵ���
er = numel(bad) / size(y, 2);                                       % ���������    

end
