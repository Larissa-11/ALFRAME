classdef f11 < func_class 
   methods
        %% �����㺯��
        function [f, g, h] = object_function(obj, x , specific )
            % ע������xΪ������
            % specific Ԥ��ֵ,����ʹ�ýṹ����,���ڴ��ݶ���Ĳ���
            % f(x) = 
            % g(x) <= 0
            % h(x) = 0
            g = 0;
            h = 0;
            n = length(x);
            F = 1 + (x+1)*0.25;
            f = 10*sin(pi*F(1))^2 + (F(n)-1)^2;
            for i=1:(n-1)
                f = f + (F(i)-1)^2*(1+10*sin(pi*F(i+1))^2);
            end
            f = pi*f/n;
            for i=1:n
                f = f + ux(obj,x(i),10,100,4);
            end
        end
        
       %% ���캯�� constructed function
        function obj = f11(specific)
            % specific Ԥ��ֵ,ʹ�ýṹ����,���ڴ��ݶ���Ĳ���
            % ���ú���������Ĭ��ֵ
                if ~exist('specific','var')
                    specific = [];  % ������ʼ��
                end
                if ~isfield(specific,'Xdim') specific.Xdim = 30;  end % ����ά��
                if ~isfield(specific,'Xmin') specific.Xmin = -600*ones(specific.Xdim,1); end  % �½� 
                if ~isfield(specific,'Xmax') specific.Xmax = 600*ones(specific.Xdim,1);  end   % �Ͻ�
                if ~isfield(specific,'Fmin') specific.Fmin = 0;  end  % Ŀ�꺯����Сֵ
                if ~isfield(specific,'Tex')  specific.Tex  =  'f=\frac{1}{4000}\sum\limits_{i=1}^Dx_i^2-\prod_{i=1}^D\cos\left(\frac{x_i}{\sqrt{i}}\right)';   end   % ����tex���ʽ
                if ~isfield(specific,'Nobj') specific.Nobj = 1;  end  % Ŀ�꺯��ֵ����
                if ~isfield(specific,'Fneq') specific.Fneq = 0;  end  % ����ʽԼ��
                if ~isfield(specific,'Feq')  specific.Feq  = 0;  end  % ��ʽԼ��
            obj = obj@func_class(specific);
        end
        function FF = u(x,a,k,m)
			FF = 0;
			if (x>a) FF = k*power(x-a,m);  end
			if (x<-a) FF = k*power(-x-a,m);  end
        end
        function FF = ux(~,x,a,k,m)
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
				FF = 0;
                if (x>a) FF = k*power(x-a,m);  end
                if (x<-a) FF = k*power(-x-a,m);  end
            end
        end
   end
end    
