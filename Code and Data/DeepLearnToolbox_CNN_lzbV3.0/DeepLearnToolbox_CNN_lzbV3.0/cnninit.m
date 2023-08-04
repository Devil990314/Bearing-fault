function net = cnninit(net)
% CNN����,��ʼ��

n = numel(net.layers);                                          % CNN�������

for L = 2 : n                                                   % ��CNN���������ѭ��(ע��:����ʵ���Ͽ��Դӵ�2�㿪ʼ)

    %======================================================================
    % ���´�����Ե�2,4��(�����)��Ч
    
    if (strcmp(net.layers{L}.type, 'c'))
        
        % ��ǰһ��ͼ��������,�ͱ������˳߶�,���㱾��ͼ��������,��ά����
        net.layers{L}.iSizePic = net.layers{L-1}.iSizePic - net.layers{L}.iSizeKer + 1;
        
        % "ǰһ������һ��ͨ��",��Ӧ"��������ͨ��"�����ȨֵW(��ѵ������)����,����������ƫ��
        fan_out = net.layers{L}.iChannel * net.layers{L}.iSizeKer ^ 2;
        
        % "ǰһ������ͨ��",��Ӧ"��������һ��ͨ��"�����ȨֵW(��ѵ������)����,����������ƫ��
        fan_in = net.layers{L-1}.iChannel * net.layers{L}.iSizeKer ^ 2;
        
        for J = 1 : net.layers{L}.iChannel                      % �Ա������ͨ������ѭ��
            
            for I = 1 : net.layers{L-1}.iChannel                % �Ա�������ͨ������ѭ��
                
                % "ǰһ������ͨ��",��"��������ͨ��",��Բ��ȫ����,�����ȨֵW,���о��ȷֲ���ʼ��,��ΧΪ:[-1,1]*sqrt(6/(fan_in+fan_out))
                net.layers{L}.Ker{I}{J} = (rand(net.layers{L}.iSizeKer) - 0.5) * 2 * sqrt(6 / (fan_in + fan_out));
                net.layers{L}.Ker_delta{I}{J} = zeros(size(net.layers{L}.Ker{I}{J}));
            end
            net.layers{L}.B{J} = 0;                             % �Ա������ͨ������ƫ�ý���0ֵ��ʼ��
            net.layers{L}.B_delta{J} = 0;
        end
        
    end
    
    %======================================================================
    % ���´���Ե�3,5��(�²�����)��Ч
    
    if (strcmp(net.layers{L}.type, 's'))        
        
        % ��ǰһ��ͼ��������,�ͱ����²����߶�,���㱾��ͼ��������,��ά����
        net.layers{L}.iSizePic = floor(net.layers{L-1}.iSizePic / net.layers{L}.iSample);
        net.layers{L}.iChannel = net.layers{L-1}.iChannel;
        
        %##################################################################
        % ��ģ����´��������²�����ļ���
        for J = 1 : net.layers{L}.iChannel
            
            net.layers{L}.Beta{J} = 1;                          % �Ա������ͨ������ƫ�ý���1ֵ��ʼ��
            net.layers{L}.Beta_delta{J} = 0;            
            
            net.layers{L}.B{J} = 0;                             % �Ա������ͨ������ƫ�ý���0ֵ��ʼ��
            net.layers{L}.B_delta{J} = 0;            
            
        end
    end
    
    %======================================================================
    
    if (strcmp(net.layers{L}.type, 'f'))

        if (strcmp(net.layers{L-1}.type, 's') || strcmp(net.layers{L-1}.type, 'c') || strcmp(net.layers{L-1}.type, 'i'))
        %------------------------------------------------------------------
        % ���´���Ե�6��(����ȫ���Ӳ�)��Ч            
            
            fvnum = prod(net.layers{L-1}.iSizePic) * net.layers{L-1}.iChannel;          % ÿ��ͨ�������ظ��� * ����ͨ���� = ��һ��ȫ�����������
            onum = net.layers{L}.iChannel;                                              % �����������
            
            net.layers{L}.W = (rand(onum, fvnum) - 0.5) * 2 * sqrt(6 / (onum + fvnum)); % ��������ƫ��0ֵ��ʼ��
            net.layers{L}.W_delta = zeros(size(net.layers{L}.W));                       % ��������ƫ��0ֵ��ʼ��            
            
            net.layers{L}.B = zeros(onum, 1);                                           % ��������ƫ��0ֵ��ʼ��
            net.layers{L}.B_delta = zeros(onum, 1);                                     % ��������ƫ��0ֵ��ʼ��
        
        elseif (strcmp(net.layers{L-1}.type, 'f'))
        %------------------------------------------------------------------
        % ���´���Ե�7��(ȫ���Ӳ�)��Ч
            
            fvnum = net.layers{L-1}.iChannel;                                           % ÿ��ͨ�������ظ��� * ����ͨ���� = ��һ��ȫ�����������
            onum = net.layers{L}.iChannel;                                              % �����������
            
            net.layers{L}.W = (rand(onum, fvnum) - 0.5) * 2 * sqrt(6 / (onum + fvnum)); % ��������ƫ��0ֵ��ʼ��
            net.layers{L}.W_delta = zeros(size(net.layers{L}.W));                       % ��������ƫ��0ֵ��ʼ��
            
            net.layers{L}.B = zeros(onum, 1);                                           % ��������ƫ��0ֵ��ʼ��
            net.layers{L}.B_delta = zeros(onum, 1);                                     % ��������ƫ��0ֵ��ʼ��
            
        %------------------------------------------------------------------            
        end
        
    end
    
    %======================================================================
    
end

end
