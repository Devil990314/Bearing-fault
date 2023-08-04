function [Y] = normalize_lzb(X)
% ����ͼƬ��һ����[0 1],double��

if ndims(X)==3
    L = size(X,3);
    Y = zeros(size(X));
    for K = 1:L
        Y(:,:,K) = subfun(X(:,:,K));
    end
elseif ndims(X)<3
    Y = subfun(X);
else
    Y = X;
end

end

%%

function [Y] = subfun(X)
% ����ͼƬ��һ����[0 1], double��

minX = min(X(:));
maxX = max(X(:));

if maxX>minX
    Y = (X-minX)./(maxX-minX);
else
    Y = zeros(size(X));
end

end

