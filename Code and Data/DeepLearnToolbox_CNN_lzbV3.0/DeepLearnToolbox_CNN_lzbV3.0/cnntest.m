function [er, bad] = cnntest(net, x, y)
% CNN����,����

net = cnnff(net, x);                                                % ǰ�򴫲��õ����

% [Y,I] = max(X) returns the indices of the maximum values in vector I
[~, h] = max(net.Y);                                                % �ҵ����������Ӧ�ı�ǩ

[~, a] = max(y);                                                    % �ҵ��������������Ӧ������

bad = find(h ~= a);                                                 % �ҵ����ǲ���ͬ�ĸ�����Ҳ���Ǵ���Ĵ���

er = numel(bad) / size(y, 2);                                       % ���������

end
