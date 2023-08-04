
clear all; close all; clc;
% CNN - ������

% addpath('../data');                                     % ����Ŀ¼
% addpath('../util');                                     % �Ӻ���Ŀ¼

%--------------------------------------------------------------------------

% % train_x - uint8����, 60000*784����, ÿһ��һ������28*28=784, ��60000��
% % test_x - uint8����, 10000*784����, ÿһ��һ������28*28=784, ��10000��
% % train_y - uint8����, 60000*10����, ÿһ��һ��BPĿ��ʸ��, ��60000��
% % test_y - uint8����, 10000*10����, ÿһ��һ��BPĿ��ʸ��, ��10000��

% load mnist_uint8;
% 
% train_x = double(reshape(train_x',28,28,60000))/255;    % ��һ����0-1֮��, ÿһ��һ��28*28������
% train_y = double(train_y');                             % ÿһ��һ��BPĿ��ʸ��
% 
% test_x = double(reshape(test_x',28,28,10000))/255;
% test_y = double(test_y');

%--------------------------------------------------------------------------

load('TrainTestSample.mat','SAMPLE','TARBP','TARSVM');
train_x = normalize_lzb(double(SAMPLE));                            % ����ͼƬ��һ����[0 1], double��
train_y = double(TARBP);

test_x = train_x;
test_y = train_y;

%--------------------------------------------------------------------------

kk = randperm(size(train_x,3));                                                   % ����ѵ������˳��

figure;
for I=1:25
    i = kk(I);
    Y1 = train_x(:,:,i)*255;                                      % �ر�ע��: ԭͼΪ����0,255�Ķ�ֵ��ͼ��
    Y2 = Y1;                                                     % ԭʼ���ݰ�C�����з���洢,������ʾ��Ҫת��
    t = find(train_y(:,i))-1;                                     % Ŀ��ֵ,���δ�0-9��������
    subplot(5,5,I); imshow(uint8(Y2)); title(num2str(t));
end

%--------------------------------------------------------------------------
% ��ʼ��һ��CNN����

% net����ṹ����
net.layers = {
    struct('type','i','iChannel',1,'iSizePic',[32 32])          % �����:         'i',iChannel�����ͨ��������ͼƬ��СiSizePic
    struct('type','c','iChannel',2,'iSizeKer',5)                % �����:         'c',iChannel�����ͨ��������˴�С[iSizePic iSizePic]
    struct('type','s','iSample',2)                              % �²�����:       's',�����²�����[iSample iSample]
    struct('type','c','iChannel',4,'iSizeKer',5)                % �����:         'c',iChannel�����ͨ��������˴�С[iSizePic iSizePic]
    struct('type','s','iSample',2)                              % �²�����:       's',�����²�����[iSample iSample]
    struct('type','f','iChannel',120)                           % ȫ���Ӳ�:       'f',iChannel������ڵ�    
    struct('type','f','iChannel',84)                            % ȫ���Ӳ�:       'f',iChannel������ڵ�
    struct('type','f','iChannel',10)                            % ȫ���Ӳ�:       'f',iChannel������ڵ�    
              };
net.alpha = 2;                                                  % ѧϰ��[0.1,3]
net.eta = 0.5;                                                  % ����ϵ��[0,0.95],>=1��������==0Ϊ���ù�����
net.batchsize = 10;                                             % ÿ����batchsize����������һ��delta����һ��Ȩֵ
net.epochs = 25;                                                % ѵ���������������        

%--------------------------------------------------------------------------
% ��������ṹ����net.layers,��ʼ��һ��CNN����

net = cnninit(net);

%--------------------------------------------------------------------------
% CNN����ѵ��

net = cnntrain(net, train_x, train_y);

%--------------------------------------------------------------------------
% CNN�������

% Ȼ����ò�������������
[er, bad] = cnntest(net, test_x, test_y);

%--------------------------------------------------------------------------

figure;
%plot mean squared error
plot(net.ERR);
%show test error
disp([num2str(er*100) '% error']);

