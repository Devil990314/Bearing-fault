function net = cnnbp2(net, y)
% CNN����,���򴫲�(�������㷨)(C���з��)

n = numel(net.layers);                                              % CNN�������

E = net.layers{n}.X - y;                                            % ������: Ԥ��ֵ-����ֵ
net.layers{n}.Delta = E .* dy(net.layers{n}.X);                     % �����������(�в�)

net.err = 1/2* sum(E(:) .^ 2);                                      % ���ۺ����Ǿ������,�Ѷ���������ƽ��
% net.err = 1/2* sum(E(:) .^ 2) / size(E, 2);                         % ���ۺ����Ǿ������,�Ѷ���������ƽ��

%% ������(�в�)�ķ��򴫲�

if strcmp(net.layers{2}.type, 'f')
   % ���ڶ������ȫ���Ӳ�ʱ,�൱������ͼƬ����һ������ʸ���γɵ�BP����,���ǵ��������net.layers{1}.X_Array,����L�����ޱ��뵽1
   tmp = 1;                                                         
else
   % �������L������2�Ϳ��� 
   tmp = 2;
end

for L = (n - 1) : -1 : tmp
    
    %======================================================================
    % ���´���ԡ���һ�㡱Ϊ��ȫ���Ӳ㡱ʱ��Ч
    
    if (strcmp(net.layers{L+1}.type, 'f'))

        if (strcmp(net.layers{L}.type, 'f'))
        %------------------------------------------------------------------
        % ���´���Ե�7��(ȫ���Ӳ�)��Ч
            
            % ���͵�BP���������������������(�в�)�ķ��򴫲���ʽ
            net.layers{L}.Delta = (net.layers{L+1}.W' * net.layers{L+1}.Delta) .* dy(net.layers{L}.X);
        
        elseif (strcmp(net.layers{L}.type, 's') || strcmp(net.layers{L}.type, 'c') || strcmp(net.layers{L}.type, 'i'))
        %------------------------------------------------------------------
        % ���´���Ե�6��(����ȫ���Ӳ�)��Ч            

            sa = size(net.layers{L}.X{1});                          % ÿ�����ͨ��ͼ��ߴ�(��άʸ��,ǰ��ά�ǳߴ�,����ά����������������)
            fvnum = sa(1) * sa(2);                                  % ���ͼ�����ظ���
            
            % ���͵�BP���������������������(�в�)�ķ��򴫲���ʽ
            net.layers{L}.Delta_Array = (net.layers{L+1}.W' * net.layers{L+1}.Delta);
            if strcmp(net.layers{L}.type, 'c')
                net.layers{L}.Delta_Array = net.layers{L}.Delta_Array .* dy(net.layers{L}.X_Array);
            end            
            
            for J = 1 : net.layers{L}.iChannel
                
                % �����㳤ʸ��������(�в�),ÿһ��Ϊһ������,reshape��ͨ����ʾ (ʸ����ȫ���� -> ͨ����ȫ����)
                net.layers{L}.Delta{J} = reshape(net.layers{L}.Delta_Array (((J - 1) * fvnum + 1) : J * fvnum, :), sa(1), sa(2));
%                 net.layers{L}.Delta{J} = reshape(net.layers{L}.Delta_Array (((J - 1) * fvnum + 1) : J * fvnum, :), sa(1), sa(2), sa(3));

            end
            
        %------------------------------------------------------------------            
        end
    end
    
    %======================================================================
    % ���´���ԡ���һ�㡱Ϊ���²����㡱ʱ��Ч
    
    if (strcmp(net.layers{L+1}.type, 's'))        
        
        for J = 1 : net.layers{L}.iChannel                          % �Ա������ͨ������ѭ��
            
            tmp1 = dy(net.layers{L}.X{J});                          % Ϊ���㵼��
            
            % Ϊ�ϲ�������,������expand�������������е�kron(kron�����ö�ά���)
            tmp2 = up(net.layers{L + 1}.Delta{J}, net.layers{L + 1}.iSample);
%             tmp2 = expand(net.layers{L + 1}.Delta{J}, [net.layers{L + 1}.iSample,net.layers{L + 1}.iSample,1]);   
            
            % net.layers{L}.Delta{J} = net.layers{L}.X{J} .* (1 - net.layers{L}.X{J}) .* (expand(net.layers{L + 1}.Delta{J}, [net.layers{L + 1}.iSample net.layers{L + 1}.iSample 1]) / net.layers{L + 1}.iSample ^ 2);
            % ����ʽ���, ��������Ϊ��ò�����net.layers{L + 1}.iSample ^ 2, ��Ϊ��CNN������㺯��cnnff��ֻ�����²�������, ������Ϊ������(�в�)��ֱ�Ӹ��ƹ�ȥ��.
            
            %##############################################################
            % ��ģ����´��������²�����ļ���       
            net.layers{L}.Delta{J} = tmp1 .* tmp2;              
            net.layers{L}.Delta{J} = net.layers{L+1}.Beta{J} * net.layers{L}.Delta{J}; 
            
        end

    end
    
    %======================================================================
    % ���´���ԡ���һ�㡱Ϊ������㡱ʱ��Ч
    
    if (strcmp(net.layers{L+1}.type, 'c'))        
        
        for I = 1 : net.layers{L}.iChannel                          % �Ա������ͨ������ѭ��
            
            z = zeros(size(net.layers{L}.X{1}));
            for J = 1 : net.layers{L+1}.iChannel                    % ����һ�����ͨ������ѭ��
                
                % ��ǰ��������(�в�)net.layers{L}.Delta{J}����
                z = z + conv2(net.layers{L + 1}.Delta{J}, rot180(net.layers{L + 1}.Ker{I}{J},2), 'full');
%                 z = z + convn(net.layers{L + 1}.Delta{J}, rot180(net.layers{L + 1}.Ker{I}{J},2), 'full');

            end
            net.layers{L}.Delta{I} = z;
%             net.layers{L}.Delta{I} = dy(net.layers{L}.X{I}) .* net.layers{L}.Delta{I};            
        end        

    end
    
    %======================================================================
    
end

%% ��ѵ���������ݶ�

% �ر�ע�⣺��Matlab���а汾��ͬ������C�����Ǵ��л��ƣ�����ѵ��������������Ҫ�ۼӣ�֮���ں���cnngradmean()�ж�һ��������ƽ��
% net.layers{L}.Ker_grad{I}{J}
% net.layers{L}.B_grad{J}
% net.layers{L}.W_grad
% net.layers{L}.B_grad
%
% ������ Notes on Convolutional Neural Networks �в�ͬ������� �Ӳ��� ��û�в�����Ҳû��
% ��������������Ӳ�������û����Ҫ���Ĳ�����

for L = 2 : n                                                       % ��CNN���������ѭ��(ע��:����ʵ���Ͽ��Դӵ�2�㿪ʼ)
    
    %======================================================================
    
    if (strcmp(net.layers{L}.type, 'c'))     
        
        for J = 1 : net.layers{L}.iChannel                          % �Ա������ͨ������ѭ��
            
            for I = 1 : net.layers{L-1}.iChannel                    % ����һ�����ͨ������ѭ��
                
                % �ر�ע��:
                % (1)�ȼ۹�ϵ rot180(conv2(a,rot180(b),'valid')) = conv2(rot180(a),b,'valid')
                % (2)��ndims(a)=ndims(b)=3,��convn(filpall(a),b,'valid')��ʾ����ά����ͬʱ�������
                % (3)��size(a,3)=size(b,3),����ʽ�������άΪ1,��ʾ����ѵ�������ĵ��Ӻ�(�������㷨),���Ҫ����������ƽ��
                
                net.layers{L}.Ker_grad{I}{J} = net.layers{L}.Ker_grad{I}{J} + conv2(rot180(net.layers{L - 1}.X{I},2), net.layers{L}.Delta{J}, 'valid');
%                 net.layers{L}.Ker_grad{I}{J} = convn(rot180(net.layers{L - 1}.X{I},3), net.layers{L}.Delta{J}, 'valid') / size(net.layers{L}.Delta{J}, 3);
                
            end
            
            % ������net.layers{L}.Delta{J}�ĵ���,���Ҫ����������ƽ��
            net.layers{L}.B_grad{J} = net.layers{L}.B_grad{J} + sum(net.layers{L}.Delta{J}(:));
%             net.layers{L}.B_grad{J} = sum(net.layers{L}.Delta{J}(:)) / size(net.layers{L}.Delta{J}, 3);
            
        end
              
    end
    
    %######################################################################
    % ��ģ����´��������²�����ļ���     
    
    if (strcmp(net.layers{L}.type, 's'))   
       
        for J = 1 : net.layers{L}.iChannel                          % �Ա������ͨ������ѭ��
            
            net.layers{L}.Beta_grad{J} = net.layers{L}.Beta_grad{J} + sum(net.layers{L}.Delta{J}(:) .* net.layers{L}.X_down{J}(:));
%             net.layers{L}.Beta_grad{J} = sum(net.layers{L}.Delta{J}(:) .* net.layers{L}.X_down{J}(:)) / size(net.layers{L}.Delta{J}, 3);            
            
            % ������net.layers{L}.Delta{J}�ĵ���,���Ҫ����������ƽ��
            net.layers{L}.B_grad{J} = net.layers{L}.B_grad{J} + sum(net.layers{L}.Delta{J}(:));      
%             net.layers{L}.B_grad{J} = sum(net.layers{L}.Delta{J}(:)) / size(net.layers{L}.Delta{J}, 3);  
        end
        
    end    
    
    %======================================================================
    
    if (strcmp(net.layers{L}.type, 'f'))

        if (strcmp(net.layers{L-1}.type, 's') || strcmp(net.layers{L-1}.type, 'c') || strcmp(net.layers{L-1}.type, 'i'))
        %------------------------------------------------------------------
        % ���´���Ե�6��(����ȫ���Ӳ�)��Ч           
        
            % Ȩֵ�����ݶ�,���Ҫ����������ƽ��
            net.layers{L}.W_grad = net.layers{L}.W_grad + net.layers{L}.Delta * (net.layers{L-1}.X_Array)';
%             net.layers{L}.W_grad = net.layers{L}.Delta * (net.layers{L-1}.X_Array)' / size(net.layers{L}.Delta, 2);

            % �����������(�в�)����ƫ��(����)���ݶ�,����ҲҪ����������ƽ��              
            net.layers{L}.B_grad = net.layers{L}.B_grad + net.layers{L}.Delta;
%             net.layers{L}.B_grad = mean(net.layers{L}.Delta, 2);
        
        elseif (strcmp(net.layers{L-1}.type, 'f'))
        %------------------------------------------------------------------
        % ���´���Ե�7��(ȫ���Ӳ�)��Ч
        
            % Ȩֵ�����ݶ�,���Ҫ����������ƽ��
            net.layers{L}.W_grad = net.layers{L}.W_grad + net.layers{L}.Delta * (net.layers{L-1}.X)';
%             net.layers{L}.W_grad = net.layers{L}.Delta * (net.layers{L-1}.X)' / size(net.layers{L}.Delta, 2);            

            % �����������(�в�)����ƫ��(����)���ݶ�,����ҲҪ����������ƽ��              
            net.layers{L}.B_grad = net.layers{L}.B_grad + net.layers{L}.Delta;
%             net.layers{L}.B_grad = mean(net.layers{L}.Delta, 2);
        
        %------------------------------------------------------------------            
        end
    end
    
    %======================================================================
    
end

end
