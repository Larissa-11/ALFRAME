classdef multimodal_f7 < func_class 
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
              for i = 1:n
                y = y - sin(x(i))*(sin(i*x(i)^2/pi))^m;
              end
            end
        end
       %% ���캯��
        function obj = multimodal_f7(specific)
            % �������½��Լ�ά��
            % [0 pi] 
            % [-50 50] ���ֵķǳ�����
            
            specific.Xdim = 30;  %����ά��
            specific.Xmin = 0*ones(specific.Xdim,1); %�½�
            specific.Xmax = pi*ones(specific.Xdim,1);  %�Ͻ�
            obj = obj@func_class(specific);
        end
   end
end