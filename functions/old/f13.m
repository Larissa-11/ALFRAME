classdef f13  < func_class 
   methods
       %% �����㺯��
        function [f, g, h] = object_function(obj, x , specific )
            % ע������xΪ�б���
			swarmsize = size( x , 2 );
            if swarmsize > 1
            % ����һ����Ⱥ�ĺ���ֵ
				y = [];  
                for i = 1:swarmsize
                    y(i) = object_function(obj, x(:,i) );
                end
            else
				% ����һ�������ĺ���ֵ
                aa = [-32,-16,0,16,32,-32,-16,0,16,32,-32,-16,0,16,32,-32,-16,0,16,32,-32,-16,0,16,32;
                   -32,-32,-32,-32,-32,-16,-16,-16,-16,-16,0,0,0,0,0,16,16,16,16,16,32,32,32,32,32];
                n = length(x);
                y = 0;  
                for j=1:2
                    temp = j;
                    for i=1:n
                       temp = temp +  power(x(i)-aa(j,i),6);
                    end
                    y = y + 1.0/temp;
                end
                y = y + 0.002;
                y = 1.0/y;
            end
            f = y;
            g = [];
            h = [];
        end
       %% ���캯��
%         function obj = f13(specific)
%             % �������½��Լ�ά��
%             specific.Xdim = 25;          %����ά��
%             specific.Xmin = -50*ones(specific.Xdim,1);   %�½�
%             specific.Xmax = 50*ones(specific.Xdim,1);  %�Ͻ�
%             obj = obj@func_class(specific);
%         end
        function obj = f13(specific)
            % specific Ԥ��ֵ,ʹ�ýṹ����,���ڴ��ݶ���Ĳ���
            % ���ú���������Ĭ��ֵ
                if ~exist('specific','var')
                    specific = [];  % ������ʼ��
                end
                if ~isfield(specific,'Xdim') specific.Xdim = 25;  end % ����ά��
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