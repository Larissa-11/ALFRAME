classdef multimodal_f3 < func_class 
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
                y = 0; n = length(x);
                f1 = sum(x.^2)/n;
                f1 = -20*exp(-0.2*sqrt(f1));
                f2 = sum(cos(2*pi*x))/n;
                f2 = exp(f2);
                y = f1 - f2 + 20 + exp(1);
            end
        end
       %% ���캯��
        function obj = multimodal_f3(specific)
            % �������½��Լ�ά��
            specific.Xdim = 30;  %����ά��
            specific.Xmin = -20*ones(specific.Xdim,1); %�½�
            specific.Xmax = 20*ones(specific.Xdim,1);  %�Ͻ�
            obj = obj@func_class(specific);
        end
   end
end