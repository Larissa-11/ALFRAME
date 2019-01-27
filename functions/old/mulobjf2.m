classdef mulobjf2 < func_class 
   methods
       %% �����㺯��
        function  y = fun_fitness(obj, x , specific )
            % ע������xΪ�б���
            % specific Ԥ��ֵ,����ʹ�ýṹ����,���ڴ��ݶ���Ĳ���
            swarmsize = size( x , 2 );
            if swarmsize > 1
            % ����һ����Ⱥ�ĺ���ֵ
				y = zeros(swarmsize,2);  
                for i = 1:swarmsize
                    y(i,:) = fun_fitness(obj, x(:,i) );
                end
            else
            % ����һ�������ĺ���ֵ
                y = [0 0]';
				y(1) = sum(x.^2) ;
                y(2) = sum((x-2).^2) ;
            end
        end
        
       %% ���캯��
        function obj = mulobjf2(obj,specific)
            % ���캯�� ,����һ��������
            specific.Xdim = 30;  %����ά��
            specific.Xmin = -1000*ones(specific.Xdim,1); %�½�
            specific.Xmax = -1000*ones(specific.Xdim,1);  %�Ͻ�
            obj = obj@func_class(specific);
        end
   end
end