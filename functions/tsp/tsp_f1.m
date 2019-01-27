classdef tsp_f1 < func_class 
   methods
       %% �����㺯��
        function  [y g h] = object_function(obj,x,specific)
            % ע������xΪ�б���
            % specific Ԥ��ֵ,����ʹ�ýṹ����,���ڴ��ݶ���Ĳ���
            y =0;
            g=[];
            h=[];
            n = obj.Xdim;
            for j = 1:(n - 1)
              y = y + specific.D(x(j),x(j + 1));
            end
            y = y + specific.D(x(n),x(1));
        end
        
       %% �������֮��ľ���
        function  [n,Distance citys] = cal_distance(obj, specific )
            %% ��������
            load ./functions/tsp/data/citys_data.mat
            
            %% ������м��໥����
            n = size(citys,1); % claculate the number of nodes
            Distance = zeros(n,n);
            for i = 1:n
                for j = 1:n
                    if i ~= j
                        Distance(i,j) = sqrt(sum((citys(i,:) - citys(j,:)).^2));
                    else
                        Distance(i,j) = 1e-4;      
                    end
                end    
            end
        end
        
       %% ���캯��
        function obj = tsp_f1(in_spec)
            % ���캯�� ,����һ��������
            if ~exist('specific','var')
                specific = [];  % ������ʼ��
            end
            if ~isfield(specific,'Xdim') specific.Xdim = 30;  end % ����ά��
            if ~isfield(specific,'Xmin') specific.Xmin = -100*ones(specific.Xdim,1); end  % �½� 
            if ~isfield(specific,'Xmax') specific.Xmax = 100*ones(specific.Xdim,1);  end   % �Ͻ�
            if ~isfield(specific,'Fmin') specific.Fmin = 0;  end  % Ŀ�꺯����Сֵ
            if ~isfield(specific,'Tex')  specific.Tex  = 'f=\sum\limits_{i=1}^D x_i^2';  end   % ����tex���ʽ
            if ~isfield(specific,'Nobj') specific.Nobj = 1;  end  % Ŀ�꺯��ֵ����
            if ~isfield(specific,'Fneq') specific.Fneq = 0;  end  % ����ʽԼ��
            if ~isfield(specific,'Feq')  specific.Feq  = 0;  end  % ��ʽԼ��
            obj = obj@func_class(specific);
        end
   end
end