% https://blog.csdn.net/ZSZ_shsf/article/details/53725343?utm_medium=distri
% bute.pc_relevant.none-task-blog-2~default~baidujs_baidulandingword~default-0-53725343-
% blog-128587626.235^v38^pc_relevant_sort_base1&spm=1001.2101.3001.4242.1&utm_relevant_index=3
% 三点对称差分能量算子求解包络
function [A,f] = Code_DESA(x)



% 算法详细描述：

% 2Ψ[x(n)]

% |a(n)|=-------------------------------------

% sqrt( Ψ[ x(n+1)-x(n-1) ] )

phix = DEO3S(x);

phix1 = DEO3S(circshift(x',-1)'-circshift(x',1)');

U = 2*phix;

L = abs(sqrt(phix1));

A=abs(U./L); % 应去除分母为0的点

A(A==inf)=0;

pha = 1-phix1/2./phix;

pha(pha>1 & pha<-1) = 0;

f = 0.5*acos(pha);

end

function f=DEO3S(x)

% 使用传递函数法求解三点对称差分能量算子

% x：行向量

% H(z)=z(1+2*z^-1+z^-2)/4;

Px=Phid(x);

Ns=length(Px);

w=2*pi*(-Ns/2:Ns/2)/Ns;

w=[w(1:Ns/2),w(Ns/2+1:Ns)]; % 去0点

z=exp(1i*w);

Hz=z.*(1+2*z.^-1+z.^-2)/4;

Xz=fft(Px,Ns);

Xz=[Xz(Ns/2+1:Ns),Xz(1:Ns/2)];%重新排列

Yw=Hz.*Xz;

Yw=[Yw(Ns/2+1:Ns),Yw(1:Ns/2)];

f=real(ifft(Yw));

end

function f=Phid(x)
% 三点对称差分能量算子
% Teager能量算子：y=x(n)^2-x(n-1)*x(n+1)

x=x';

f=x.^2-circshift(x,1).*circshift(x,-1);

f=f';

end