classdef unimodal_f6  < func_class 
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
				ff = floor(x+0.5).^2;
                y = sum(ff);  
            end
        end
       %% ���캯��
        function obj = unimodal_f6(specific)
            % �������½��Լ�ά��
            specific.Xdim = 30;  %����ά��
            specific.Xmin = -100*ones(specific.Xdim,1); %�½�
            specific.Xmax = 100*ones(specific.Xdim,1);  %�Ͻ�
            obj = obj@func_class(specific);
        end
   end
end