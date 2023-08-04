% Illustrates usage of 'Fast_kurtogram' on a synthetic signal
% -----------------------------------------------------------
% This example illustrates the detection of weak repetitive transients
% hidden in stationary noise; their theoretical spectral content is in band [.15 .19].
%
% --------------------------
% Author: J. Antoni
% Last Revision: 12-2014
% --------------------------

load x
Fs = 1;         % sampling frequency

figure,plot(x,'k'),title('Signal with hidden repetitive transients')

nlevel = 7;     % number of decomposition levels

% Pre-whitening of the signal by AR filtering (optional)
% (always helpful in detection problems)
prewhiten = input('Do you want to prewhiten the signal? (no = 0 ; yes = 1): ');
if prewhiten == 1
   x = x - mean(x);
   Na = 100;
   a = lpc(x,Na);
   x = fftfilt(a,x);
   x = x(Na+1:end);		% it is very important to remove the transient of the whitening filter, otherwise the SK will detect it!!
end

% Fast Kurtogram
c = Fast_kurtogram(x,nlevel,Fs);


