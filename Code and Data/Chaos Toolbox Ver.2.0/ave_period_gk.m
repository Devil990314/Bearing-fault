function P=ave_period_gk(data)

N=length(data);
a0 = abs(fft(data));
a0(1)=[];
a = a0(1:N/2);

fa_0=0;%初始化，记录f*A的累加结果
a_0=0;%初始化，记录A的累加结果

for i=1:N/2
    fa_0 = fa_0 + a(i)*i/N;
    a_0 = a_0+a(i);
end

P0 = 1/(fa_0/a_0);
P = round(P0);