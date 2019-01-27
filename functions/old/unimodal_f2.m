classdef unimodal_f2  < func_class 
   methods
       %% �����㺯��
        function  y = fun_fitness(obj, x , specific )
            % ע������xΪ�б���
            % specific Ԥ��ֵ,����ʹ�ýṹ����,���ڴ��ݶ���Ĳ���
            swarmsize = size( x , 2 );
            if swarmsize > 1
            % ����һ����Ⱥ�ĺ���ֵ
				y = zeros(swarmsize,1);  
                for i = 1:swarmsize
                    y(i) = fun_fitness(obj, x(:,i) );
                end
            else
            % ����һ�������ĺ���ֵ
				y= 0;
                absvar = abs(x);
                y = sum(absvar);
                y1 = prod(absvar);
                y = y + y1;
            end
        end
       %% ���캯��
        function obj = unimodal_f2(specific)
            % �������½��Լ�ά��
            specific.Xdim = 30;  %����ά��
            specific.Xmin = -10*ones(specific.Xdim,1); %�½�
            specific.Xmax = 10*ones(specific.Xdim,1);  %�Ͻ�
            obj = obj@func_class(specific);
        end
   end
end