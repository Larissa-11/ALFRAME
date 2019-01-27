classdef unimodal_f7  < func_class 
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
                n = length(x);
                y = sum((1:n)'.*x.^4) + rand;
            end
        end
       %% ���캯��
        function obj = unimodal_f7(specific)
            % �������½��Լ�ά��
            specific.Xdim = 30 ;         %����ά��
            specific.Xmin = -1.28*ones(specific.Xdim,1);   %�½�
            specific.Xmax = 1.28*ones(specific.Xdim,1);  %�Ͻ�
            obj = obj@func_class(specific);
        end
   end
end