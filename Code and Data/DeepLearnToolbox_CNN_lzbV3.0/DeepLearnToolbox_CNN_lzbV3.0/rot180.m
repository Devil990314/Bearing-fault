function X = rot180(X,dim)
% �Զ�ά�����1->dimά���ݷ�ת180��

if nargin<2
    dim = 2;
end

for i=1:min(ndims(X),dim);
    X = flipdim(X,i);
end

end