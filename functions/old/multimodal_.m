classdef multimodal_f3  < func_class 
   methods
       %% �����㺯��
        function  y = fun_fitness(obj, x , specific )
            % ע������xΪ�б���
			swarmsize = size( x , 2 );
            if swarmsize > 1
            % ����һ����Ⱥ�ĺ���ֵ
				y = [];  
                for i = 1:swarmsize
                    y(i) = fun_fitness(obj, x(:,i) );
                end
            else
				% ����һ�������ĺ���ֵ
                y = 0;  n = length(x);
                for i=1:n
                    y = y - x(i)sin(sqrt(abs(x(i))));
                end
            end
        end
       %% ���캯��
        function obj = multimodal_f1(specific)
            % �������½��Լ�ά��
            specific.Xdim = 30  ;        %����ά��
            specific.Xmin = -500*ones(specific.Xdim,1);   %�½�
            specific.Xmax = 500*ones(specific.Xdim,1);  %�Ͻ�
            obj = obj@func_class(specific);
        end
   end
end