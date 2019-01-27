classdef  TNK < func_class 
   methods
       %% �����㺯��
        function [f, g, h] = object_function(obj, x , specific )
            % ע������xΪ������
            % specific Ԥ��ֵ,����ʹ�ýṹ����,���ڴ��ݶ���Ĳ���
            % f(x) = 
            % g(x) <= 0
            % h(x) = 0
            % CEC07 ����Ϊ������,���Ϊ������,ע��ת��
            g = zeros(obj.Fneq,1);
            h = zeros(obj.Feq,1);
            f = [0;0];
			f(1) = x(1);
            f(2) = x(2);
            g(1) = -x(1)^2-x(2)^2+1+0.1*cos(16*atan(x(1)/x(2)));
            g(2) = (x(1)-0.5)^2 + (x(2)-0.5)^2 -0.5;
        end
        
       %% ���캯�� constructed function
        function obj = TNK(specific)
            % specific Ԥ��ֵ,ʹ�ýṹ����,���ڴ��ݶ���Ĳ���
            % ���ú���������Ĭ��ֵ
            if ~exist('specific','var')
                specific = [];  % ������ʼ��
            end
            if ~isfield(specific,'Xdim') specific.Xdim = 2;  end % ����ά��
            if ~isfield(specific,'Xmin') specific.Xmin = -0*ones(specific.Xdim,1); end  % �½� 
            if ~isfield(specific,'Xmax') specific.Xmax = pi*ones(specific.Xdim,1);  end   % �Ͻ�
            if ~isfield(specific,'Fmin') specific.Fmin = 0;  end  % Ŀ�꺯����Сֵ
            if ~isfield(specific,'Tex')  specific.Tex  = 'f_1(x)=x^2\\f_2(x)=(x-2)^2';  end   % ����tex����ʽ
            if ~isfield(specific,'Nobj') specific.Nobj = 2;  end  % Ŀ�꺯��ֵ����
            if ~isfield(specific,'Fneq') specific.Fneq = 2;  end  % ����ʽԼ��
            if ~isfield(specific,'Feq')  specific.Feq  = 0;  end  % ��ʽԼ��
            obj = obj@func_class(specific);
        end
   end
end