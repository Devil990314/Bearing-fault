function net = cnngradmean(net, m)
% CNN����,ѵ������ƽ��(C���з��ר��)

n = numel(net.layers);                                              % CNN�������

for L = 2 : n                                                       % ��CNN���������ѭ��(ע��:����ʵ���Ͽ��Դӵ�2�㿪ʼ)
    
    %======================================================================
    
    if (strcmp(net.layers{L}.type, 'c'))        
        
        for J = 1 : net.layers{L}.iChannel                          % �Ա������ͨ������ѭ��
            for I = 1 : net.layers{L-1}.iChannel                    % ����һ�����ͨ������ѭ��
                
                % ����ûʲô��˵�ģ�������ͨ��Ȩֵ���µĹ�ʽ��W_new = W_old - alpha * de/dW������Ȩֵ������
                net.layers{L}.Ker_grad{I}{J} = net.layers{L}.Ker_grad{I}{J} / m;
                
            end
            
            % ����һ��ͨ�������Ӧһ������ƫ��net.layers{L}.B{J}
            net.layers{L}.B_grad{J} = net.layers{L}.B_grad{J} / m;
            
        end
        
        % �ر�ע��(zouxy09Դ���뿱��,����Դ������ȷ)��
        % ������һ�з��������Ǵ���ģ�Ӧ�÷�������ѭ��J�ڲ���
        % net.layers{L}.B{J} = net.layers{L}.B{J} - net.alpha * net.layers{L}.B_grad{J};

    end
    
    %######################################################################
    % ��ģ����´��������²�����ļ���     
    
    if (strcmp(net.layers{L}.type, 's'))   
       
        for J = 1 : net.layers{L}.iChannel                          % �Ա������ͨ������ѭ��
            
            net.layers{L}.Beta_grad{J} = net.layers{L}.Beta_grad{J} / m;            
            
            % ������net.layers{L}.Delta{J}�ĵ���,���Ҫ����������ƽ��
            net.layers{L}.B_grad{J} = net.layers{L}.B_grad{J} / m;            
        end
        
    end       
    
    %======================================================================
    
    if (strcmp(net.layers{L}.type, 'f'))
        
        % ����һ��ͨ�������Ӧһ������ƫ��net.layers{L}.B{J}
        net.layers{L}.W_grad = net.layers{L}.W_grad / m;
       
        
        % ����һ��ͨ�������Ӧһ������ƫ��net.layers{L}.B{J}
        net.layers{L}.B_grad = net.layers{L}.B_grad / m;
        
    end
    
    %======================================================================    
    
end

end
