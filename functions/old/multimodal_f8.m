classdef multimodal_f8 < func_class 
   methods
        %% �����㺯��
        function  y = fun_fitness(obj, x , specific )
            % ע������xΪ�б���
            swarmsize = size( x , 2 );
            n = size( x , 1 );
            y = zeros( 1 , n );
            if swarmsize > 1
            % ����һ����Ⱥ�ĺ���ֵ
                y = [];  
                for i = 1:swarmsize
                    y(i) = fun_fitness(obj, x(:,i) );
                end
            else
              % ����һ�������ĺ���ֵ
              y = 0; 
              n = length(x);
              m = 10;
              m = 2*m;
              y1 = sum((sin(x)).^2);
              y2 = exp(-sum(x.^2));
              y3 = exp( -sum( sin(sqrt(abs(x))).^2 ) );
              y = (y1 - y2)*y3;
            end
        end
       %% ���캯��
        function obj = multimodal_f8(specific)
            % �������½��Լ�ά��
            % �ǳ���Ȥ��һ������
            specific.Xdim = 30;  %����ά��
            specific.Xmin = -20*ones(specific.Xdim,1); %�½�
            specific.Xmax = 20*ones(specific.Xdim,1);  %�Ͻ�
            obj = obj@func_class(specific);
        end
   end
end