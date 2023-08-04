function net = cnnupdate(net)
% CNN����,������������Ȩֵ����(���ӹ�����)

n = numel(net.layers);                                              % CNN�������

for L = 2 : n                                                       % ��CNN���������ѭ��(ע��:����ʵ���Ͽ��Դӵ�2�㿪ʼ)
    
    %======================================================================
    
    if (strcmp(net.layers{L}.type, 'c'))        
        
        for J = 1 : net.layers{L}.iChannel                          % �Ա������ͨ������ѭ��
            for I = 1 : net.layers{L-1}.iChannel                    % ����һ�����ͨ������ѭ��
                
                % ����ûʲô��˵�ģ�������ͨ��Ȩֵ���µĹ�ʽ��W_new = W_old - alpha * de/dW������Ȩֵ������
                net.layers{L}.Ker_delta{I}{J} = net.eta * net.layers{L}.Ker_delta{I}{J} - net.alpha * net.layers{L}.Ker_grad{I}{J};
                net.layers{L}.Ker{I}{J} = net.layers{L}.Ker{I}{J} + net.layers{L}.Ker_delta{I}{J};
                
            end
            
            % ����һ��ͨ�������Ӧһ������ƫ��net.layers{L}.B{J}
            net.layers{L}.B_delta{J} = net.eta * net.layers{L}.B_delta{J} - net.alpha * net.layers{L}.B_grad{J};
            net.layers{L}.B{J} = net.layers{L}.B{J} + net.layers{L}.B_delta{J};
            
        end
        
        % �ر�ע��(zouxy09Դ���뿱��,����Դ������ȷ)��
        % ������һ�з��������Ǵ���ģ�Ӧ�÷�������ѭ��J�ڲ���
        % net.layers{L}.B{J} = net.layers{L}.B{J} - net.alpha * net.layers{L}.B_grad{J};

    end
    
    %######################################################################
    % ��ģ����´��������²�����ļ���   
    
    if (strcmp(net.layers{L}.type, 's')) 
        
        for J = 1 : net.layers{L}.iChannel                          % �Ա������ͨ������ѭ��
        
            % ����һ��ͨ�������Ӧһ������ƫ��net.layers{L}.B{J}
            net.layers{L}.B_delta{J} = net.eta * net.layers{L}.B_delta{J} - net.alpha * net.layers{L}.B_grad{J};
            net.layers{L}.B{J} = net.layers{L}.B{J} + net.layers{L}.B_delta{J};        
            
            net.layers{L}.Beta_delta{J} = net.eta * net.layers{L}.Beta_delta{J} - net.alpha * net.layers{L}.Beta_grad{J};
            net.layers{L}.Beta{J} = net.layers{L}.Beta{J} + net.layers{L}.Beta_delta{J};        
        
        end
        
    end
    
    %======================================================================
    
    if (strcmp(net.layers{L}.type, 'f'))
        
        % ����һ��ͨ�������Ӧһ������ƫ��net.layers{L}.B{J}
        net.layers{L}.W_delta = net.eta * net.layers{L}.W_delta - net.alpha * net.layers{L}.W_grad;
        net.layers{L}.W = net.layers{L}.W + net.layers{L}.W_delta;
        
        
        % ����һ��ͨ�������Ӧһ������ƫ��net.layers{L}.B{J}
        net.layers{L}.B_delta = net.eta * net.layers{L}.B_delta - net.alpha * net.layers{L}.B_grad;
        net.layers{L}.B = net.layers{L}.B + net.layers{L}.B_delta;
        
    end
    
    %======================================================================    
    
end

end
