function [u, u_hat, omega] = VMD(signal, alpha, tau, K, DC, init, tol)
% Variational Mode Decomposition����VMD
% Authors: Konstantin Dragomiretskiy and Dominique Zosso
% zosso@math.ucla.edu --- http://www.math.ucla.edu/~zosso
% Initial release 2013-12-12 (c) 2013
%
% Input and Parameters:     ���������
% ---------------------
% signal  - the time domain signal (1D) to be decomposed                ���ֽ��ʱ���ź�
% alpha   - the balancing parameter of the data-fidelity constraint     a-���ݱ����Լ����ƽ�����
% tau     - time-step of the dual ascent ( pick 0 for noise-slack )     T-˫������ʱ�䲽��(�����ɳ�ȡ0)
% K       - the number of modes to be recovered
% DC      - true if the first mode is put and kept at DC (0-freq)       �����һ��ģʽ�����ò�������DC(0Ƶ��)����Ϊ��
% init    - 0 = all omegas start at 0                                   ���д�0��ʼ
%                    1 = all omegas start uniformly distributed         1 =���ж��Ǿ��ȷֲ���
%                    2 = all omegas initialized randomly                2 =�����ʼ��������
% tol     - tolerance of convergence criterion; typically around 1e-6   ��������׼��;ͨ����Լe-6
%
% Output:                    ���
% -------
% u       - the collection of decomposed modes                             �ɼ��ֽ�ģ̬
% u_hat   - spectra of the modes                                                   ģ̬�ķ�Χ
% omega   - estimated mode center-frequencies                           ����ģ̬������Ƶ��
%
% When using this code, please do cite our paper:
% -----------------------------------------------
% K. Dragomiretskiy, D. Zosso, Variational Mode Decomposition, IEEE Trans.
% on Signal Processing (in press)
% please check here for update reference: 
%          http://dx.doi.org/10.1109/TSP.2013.2288675

%% Preparations         ׼��

% Period and sampling frequency of input signal           �����źŵ����ںͲ���Ƶ��
save_T = length(signal);                       %��������/��������
fs = 1/save_T;                                      %����Ƶ��

% extend the signal by mirroring                          ͨ��������չ�ź�
T = save_T;                                           
f_mirror(1:T/2) = signal(T/2:-1:1);        %����T/2,β��1������Ϊ-1�ġ��Ȳ����С�����
f_mirror(T/2+1:3*T/2) = signal;
f_mirror(3*T/2+1:2*T) = signal(T:-1:T/2+1);
%% ����������
f = f_mirror;                                             %������չΪԭ����2��

% Time Domain 0 to T (of mirrored signal)                 ʱ��0��1�������źţ�
T = length(f);                                            %Tm������Ϊ2T/��������
t = (1:T)/T;                                              %ʱ����/Ƶ��  �����źŵĲ�������

% Spectral Domain discretization                          Ƶ����ɢ��
freqs = t-0.5-1/T;                                       %Ƶ�ʷ�Χ[-0.5 0.5-1/T]

% Maximum number of iterations (if not converged yet, then it won't anyway)
%����������(�����û����������ô�������������������)
N = 500;

% For future generalizations: individual alpha for each mode ����δ���ĸ���:ÿ��ģ̬��alphaֵ
Alpha = alpha*ones(1,K);                    

% Construct and center f_hat                ���첢�Ҿ���f_hat   ����Ҷ�任������Ƶ�ף�����Ƶ����з����ĸ���
f_hat = fftshift((fft(f)));                           
f_hat_plus = f_hat;                                        
f_hat_plus(1:T/2) = 0;                                     %�����Ƶ����ֻ������Ƶ����

% matrix keeping track of every iterant // could be discarded for mem  
%�������ÿһ��������//����Ϊmem����            ��ʼ��ģ̬  
u_hat_plus = zeros(N, length(freqs), K);                   %����һ��N*length(freqs)*K����ά0����               

% Initialization of omega_k                   ��ʼ��omega_k
omega_plus = zeros(N, K);                                  %���� �������N �� ģ̬����
switch init
    case 1
        for i = 1:K
            omega_plus(1,i) = (0.5/K)*(i-1);
        end
    case 2
        omega_plus(1,:) = sort(exp(log(fs) + (log(0.5)-log(fs))*rand(1,K)));
    otherwise
        omega_plus(1,:) = 0;
end

% if DC mode imposed, set its omega to 0         ����DCģʽ��omega��Ϊ0
if DC
    omega_plus(1,1) = 0;
end

% start with empty dual variables                �ӿյĶ�ż������ʼ         
lambda_hat = zeros(N, length(freqs));

% other inits
uDiff = tol+eps;                    % update step     �������
n = 1;                              % loop counter     ����ѭ��������Ϊ1
sum_uk = 0;                         % accumulator  �ۼ���



% ----------- Main loop for iterative updates           ���ڵ������µ���ѭ��
          %Uk(w)       Wk(w)  ����
while ( uDiff > tol &&  n < N ) % not converged and below iterations limit   ��������С�ڵ�������  N=500
    
    % update first mode accumulator                   ��һ��ģʽ
    k = 1;
    sum_uk = u_hat_plus(n,:,K) + sum_uk - u_hat_plus(n,:,1);
    
    % update spectrum of first mode through Wiener filter of residuals    ͨ���в�ά���˲����µ�һģ̬Ƶ��
    u_hat_plus(n+1,:,k) = (f_hat_plus - sum_uk - lambda_hat(n,:)/2)./(1+Alpha(1,k)*(freqs - omega_plus(n,k)).^2);
    
    % update first omega if not held at 0            ���δ������0������µ�һ��omega
    if ~DC
        omega_plus(n+1,k) = (freqs(T/2+1:T)*(abs(u_hat_plus(n+1, T/2+1:T, k)).^2)')/sum(abs(u_hat_plus(n+1,T/2+1:T,k)).^2);
    end
    
    % update of any other mode                       ��������ģʽ2-Kģʽ
    for k=2:K
        
        % accumulator
        sum_uk = u_hat_plus(n+1,:,k-1) + sum_uk - u_hat_plus(n,:,k);
        
        % mode spectrum                              ģ̬Ƶ��
        u_hat_plus(n+1,:,k) = (f_hat_plus - sum_uk - lambda_hat(n,:)/2)./(1+Alpha(1,k)*(freqs - omega_plus(n,k)).^2);
        
        % center frequencies                         ����Ƶ��          
        omega_plus(n+1,k) = (freqs(T/2+1:T)*(abs(u_hat_plus(n+1, T/2+1:T, k)).^2)')/sum(abs(u_hat_plus(n+1,T/2+1:T,k)).^2);
        
    end
    
    % Dual ascent                              ˫����
    lambda_hat(n+1,:) = lambda_hat(n,:) + tau*(sum(u_hat_plus(n+1,:,:),3) - f_hat_plus);
    
    % loop counter                             �ۼ���
    n = n+1;
    
    % converged yet?                         �Ƿ��������ֹͣ����                   
    uDiff = eps;
    for i=1:K
        uDiff = uDiff + 1/T*(u_hat_plus(n,:,i)-u_hat_plus(n-1,:,i))*conj((u_hat_plus(n,:,i)-u_hat_plus(n-1,:,i)))';
    end
    uDiff = abs(uDiff);
    
end




%% Postprocessing and cleanup          �������������ʱ��ģ̬��Ƶ��ģ̬

% discard empty space if converged early      ����������������տռ�
N = min(N,n);                                                   %����ʵ�ʵ�������n         
omega = omega_plus(1:N,:);                             %���omega��ʵ�ʳ���Ϊ����ѭ������������ΪK      Ƶ�ʷ�Χ�ǹ̶���

% Signal reconstruction  �ؽ������Ƶ��ģ̬�źţ���ʱ�ؽ�����1��T�ڵ�Ƶ��ģ̬�źţ���ģ̬�Ľ����źż����ǲ�Ҳ���鲿
u_hat = zeros(T, K);                                                       %�ؽ��ź�Ϊ2T*K�ľ���
u_hat((T/2+1):T,:) = squeeze(u_hat_plus(N,(T/2+1):T,:));                   %�ؽ�������T/2+1:T���ź�      ��ģ̬���н�ά��ɾ������Ϊ1��ά�� 
u_hat((T/2+1):-1:2,:) = squeeze(conj(u_hat_plus(N,(T/2+1):T,:)));          %�ؽ�������2:T/2+1���ź�
u_hat(1,:) = conj(u_hat(end,:));                                           %�ؽ�������1���ź�            ȡ�����
%�ؽ������ʱ��ģ̬�ź�
u = zeros(K,length(t));                                                   
for k = 1:K
    u(k,:)=real(ifft(ifftshift(u_hat(:,k))));                              %����Ƶ��ģ̬�źŽ��з��仯��ȡ��ʵ������
end

%%  remove mirror part                         �ؽ�ʵ���źŵ�ʱ��ģ̬��������񲿷�
u = u(:,T/4+1:3*T/4);                            %�����T����Tm������ֻȡ��Tm�����ڵ�T/4+1:3*T/4

% recompute spectrum                         �ؽ�ʵ���źŵ�Ƶ��ģ̬
clear u_hat;
for k = 1:K
    u_hat(:,k)=fftshift(fft(u(k,:)))';            
end

end