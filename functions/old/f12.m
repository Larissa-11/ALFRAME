classdef f12  < func_class 
   methods
        function FF = ux(~,x,a,k,m)
			FF = 0;
			if (x>a) FF = k*power(x-a,m);  end
			if (x<-a) FF = k*power(-x-a,m);  end
        end
       %% �����㺯��
%         function  y = fun_fitness(obj, x , specific )
        function [f, g, h] = object_function(obj, x , specific )
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
                n = length(x);
                y = sin(3*pi*x(1))^2 + (x(n)-1)^2*(1+sin(2*pi*x(n))^2);
                for i=1:(n-1)
                    y = y + (x(i)-1)^2*(1+sin(3*pi*x(i+1))^2);
                end
                y = 0.1*y;
                for i=1:n
                    y = y + ux(obj,x(i),5,100,4);
                end
            end
            f = y;
            g = [];
            h = [];
        end
       %% ���캯��
%         function obj = f12(specific)
%             % �������½��Լ�ά��
%             specific.Xdim = 30;  %����ά��
%             specific.Xmin = -50*ones(specific.Xdim,1); %�½�
%             specific.Xmax = 50*ones(specific.Xdim,1);  %�Ͻ�
%             obj = obj@func_class(specific);
%         end
        function obj = f12(specific)
            % specific Ԥ��ֵ,ʹ�ýṹ����,���ڴ��ݶ���Ĳ���
            % ���ú���������Ĭ��ֵ
                if ~exist('specific','var')
                    specific = [];  % ������ʼ��
                end
                if ~isfield(specific,'Xdim') specific.Xdim = 30;  end % ����ά��
                if ~isfield(specific,'Xmin') specific.Xmin = -50*ones(specific.Xdim,1); end  % �½� 
                if ~isfield(specific,'Xmax') specific.Xmax = 50*ones(specific.Xdim,1);  end   % �Ͻ�
                if ~isfield(specific,'Fmin') specific.Fmin = 0;  end  % Ŀ�꺯����Сֵ
                if ~isfield(specific,'Tex')  specific.Tex  =  'f=\frac{1}{4000}\sum\limits_{i=1}^Dx_i^2-\prod_{i=1}^D\cos\left(\frac{x_i}{\sqrt{i}}\right)';   end   % ����tex���ʽ
                if ~isfield(specific,'Nobj') specific.Nobj = 1;  end  % Ŀ�꺯��ֵ����
                if ~isfield(specific,'Fneq') specific.Fneq = 0;  end  % ����ʽԼ��
                if ~isfield(specific,'Feq')  specific.Feq  = 0;  end  % ��ʽԼ��
            obj = obj@func_class(specific);
        end
   end
end