function [Y] = down(X,iSample)
% ͼƬ�²�������,���в�������ΪiSample

if ndims(X)==2
    
    % �Գ߶�ones(net.layers{L}.iSample)����һ����о������,�൱�ھ�ֵ�˲�
    Z = conv2(X, ones(iSample) / iSample ^ 2, 'valid');
    
    % �Լ��net.layers{L}.iSample�����Ͻ�������²���
    Y = Z(1:iSample:end, 1:iSample:end);
    
elseif ndims(X)==3
    
    % �Գ߶�ones(net.layers{L}.iSample)����һ����о������,�൱�ھ�ֵ�˲�
    Z = convn(X, ones(iSample) / iSample ^ 2, 'valid');
    
    % �Լ��net.layers{L}.iSample�����Ͻ�������²���
    Y = Z(1:iSample:end, 1:iSample:end, :);
    
end

end

