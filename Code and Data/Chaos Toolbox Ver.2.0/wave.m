function [A,D]=wave(data,N)
%��С���ֽ��ź�
%--------------��ɢС���ֽ�-----------
%clear d
%N=3;
[C,L]=wavedec(data,N,'db6');
A = wrcoef('a',C,L,'db6');%��ȡ��Ƶϵ��
%figure(1)
%str=strcat('С��',num2str(N),'��ֽ�ͼ');
% subplot(N+2,1,1);plot(data);ylabel('data');title(str);
% subplot(N+2,1,2);plot(A);ylabel('a');

for i=1:N
    D(i,:) = wrcoef('d',C,L,'db6',N-i+1);
    %subplot(N+2,1,i+2);plot(D(i,:));
%     str=num2str(N-i+1);str=strcat('d',str);
%     ylabel(str);
end
% clear i str N
% rec_signal=a6+d1+d2+d3+d4+d5+d6;

% pre_signal_local=Avalue+D1value+D2value+D3value;
% pre_signal_lyap1=Alyap1+D1lyap1+D2lyap1+D3lyap1;
% pre_signal_lyap2=Alyap2+D1lyap2+D2lyap2+D3lyap2;





