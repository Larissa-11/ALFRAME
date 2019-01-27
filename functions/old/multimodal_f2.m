classdef multimodal_f2  < func_class 
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
                y = 0;
                y = sum( x.^2 - 10*cos(2*pi*x) + 10 );
            end
        end
       %% ���캯��
        function obj = multimodal_f2(specific)
            % �������½��Լ�ά��
            specific.Xdim = 30  ;        %����ά��
            specific.Xmin = -5.12*ones(specific.Xdim,1);   %�½�
            specific.Xmax = 5.12*ones(specific.Xdim,1);  %�Ͻ�
            obj = obj@func_class(specific);
        end
   end
end