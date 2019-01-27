classdef multimodal_f4 < func_class 
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
              f1 = sum(x.^2)/4000;
              f2 = prod(cos(x'./sqrt(1:n)));
              y = f1 - f2 + 1;
            end
        end
       %% ���캯��
        function obj = multimodal_f4(specific)
            % �������½��Լ�ά��
            specific.Xdim = 30;  %����ά��
            specific.Xmin = -32*ones(specific.Xdim,1); %�½�
            specific.Xmax = 32*ones(specific.Xdim,1);  %�Ͻ�
            obj = obj@func_class(specific);
        end
   end
end