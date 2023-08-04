function net = cnnff2(net, x)
% CNN����,�������(�������㷨,������convn�÷�,�����������ӳ��)(C���з��)

n = numel(net.layers);                                          % CNN�������
net.layers{1}.X{1} = x;                                         % ����ĵ�һ���������(opts.batchsize������ͬʱ����)

for L = 2 : n                                                   % ��CNN���������ѭ��(ע��:����ʵ���Ͽ��Դӵ�2�㿪ʼ)
    
    %======================================================================
    % ���´�����Ե�2,4��(�����)��Ч
    
    if (strcmp(net.layers{L}.type, 'c'))        
        
        for J = 1 : net.layers{L}.iChannel                    % �Ա������ͨ������ѭ��
            
            % �Ա���һ��ͨ�����0ֵ��ʼ��(opts.batchsize������ͬʱ����)
            z = zeros(size(net.layers{L - 1}.X{1}) - [net.layers{L}.iSizeKer - 1, net.layers{L}.iSizeKer - 1]);
%             z = zeros(size(net.layers{L - 1}.X{1}) - [net.layers{L}.iSizeKer - 1, net.layers{L}.iSizeKer - 1, 0]);

            for I = 1 : net.layers{L-1}.iChannel                             % �Ա�������ͨ������ѭ��
                
                % �ر�ע��:
                % net.layers{L - 1}.X{I}Ϊopts.batchsize������,Ϊ��ά����
                % net.layers{L}.Ker{I}{J}Ϊ��ά����˾���
                % ��������˺���convn,ʵ�ֶ�����������ͬʱ����
                
                z = z + conv2(net.layers{L - 1}.X{I}, net.layers{L}.Ker{I}{J}, 'valid');
%                 z = z + convn(net.layers{L - 1}.X{I}, net.layers{L}.Ker{I}{J}, 'valid');

            end
            
            % ����һ��ͨ�������Ӧһ������ƫ��net.layers{L}.B{J},�ٲ���sigmoid�����
            net.layers{L}.X{J} = z + net.layers{L}.B{J};                % �����������
            net.layers{L}.X{J} = fx(net.layers{L}.X{J});                % �����������            
            
            % �ر�ע��:
            % ������漰����������:(1)���,(2)ƫ��(��),(3)sigmoidӳ��
        end
        
    end
    
    %======================================================================
    % ���´���Ե�3,5��(�²�����)��Ч
    
    if (strcmp(net.layers{L}.type, 's'))        
        
        for J = 1 : net.layers{L-1}.iChannel                    % �Ա�������ͨ������ѭ��(�������ͨ�������)
            
            % ͼƬ�²�������,���в�������ΪiSample
            
            %##################################################################
            % ��ģ����´��������²�����ļ���
            net.layers{L}.X_down{J} = down(net.layers{L - 1}.X{J}, net.layers{L}.iSample);
            net.layers{L}.X{J} = net.layers{L}.Beta{J} * net.layers{L}.X_down{J} + net.layers{L}.B{J};
%             net.layers{L}.X{J} = fx(net.layers{L}.X{J});                % �����������
         
            % �ر�ע��:
            % �²�������漰����������:(1)�²���, (2)ƫ��(�˻��),"sigmoidӳ��"���ﶼû��
        end
        
    end
    
    %======================================================================
    
    if (strcmp(net.layers{L}.type, 'f'))
        
        if (strcmp(net.layers{L-1}.type, 's') || strcmp(net.layers{L-1}.type, 'c') || strcmp(net.layers{L-1}.type, 'i'))
        %------------------------------------------------------------------
        % ���´���Ե�6��(����ȫ���Ӳ�)��Ч
        
            net.layers{L-1}.X_Array = [];
            for J = 1 : net.layers{L-1}.iChannel                            % ��ǰһ�����ͨ������ѭ��
                
                sa = size(net.layers{L-1}.X{J});                            % ��j������map�Ĵ�С(ʵ����ÿ��j�����)
                
                % �����е�����map����һ��������������һά���Ƕ�Ӧ������������ÿ������һ�У�ÿ��Ϊ��Ӧ����������
                net.layers{L-1}.X_Array = [net.layers{L-1}.X_Array; reshape(net.layers{L-1}.X{J}, sa(1) * sa(2), 1)];
%                 net.layers{L-1}.X_Array = [net.layers{L-1}.X_Array; reshape(net.layers{L-1}.X{J}, sa(1) * sa(2), sa(3))];

            end
            
            % ����������������ֵ��sigmoid(W*X + b)��ע����ͬʱ������batchsize�����������ֵ
            net.layers{L}.X = fx(net.layers{L}.W * net.layers{L-1}.X_Array + net.layers{L}.B);
%             net.layers{L}.X = fx(net.layers{L}.W * net.layers{L-1}.X_Array + repmat(net.layers{L}.B, 1, size(net.layers{L-1}.X_Array, 2)));
            
            % �ر�ע��:
            % ������漰����������:(1)��Ȩ,(2)ƫ��(��),(3)sigmoidӳ��
            
        elseif (strcmp(net.layers{L-1}.type, 'f'))
        %------------------------------------------------------------------
        % ���´���Ե�7��(ȫ���Ӳ�)��Ч            
            
            net.layers{L}.X = fx(net.layers{L}.W * net.layers{L-1}.X + net.layers{L}.B);
%             net.layers{L}.X = fx(net.layers{L}.W * net.layers{L-1}.X + repmat(net.layers{L}.B, 1, size(net.layers{L-1}.X, 2)));
            
        %------------------------------------------------------------------            
        end
    end
    
    %======================================================================
    
end

net.Y = net.layers{n}.X;

end
