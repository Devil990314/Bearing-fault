function [d] = dy(y)
% ������ӳ��Sigmoid����y=f(x)=1/(1+e(-x)),����Ϊy,���Ϊy��x�ĵ���

d = y.*(1-y);

end

