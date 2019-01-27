classdef func_handle < func_class 
   methods
        %% �����㺯��
        function [f, g, h] = object_function(obj, x , specific )
            % ע������xΪ�б���
            % specific Ԥ��ֵ,����ʹ�ýṹ����,���ڴ��ݶ���Ĳ���?
            % g(x) <= 0
            % h(x) = 0
            g = zeros(obj.Fneq,1);
            h = zeros(obj.Feq,1);
			f = obj.object_function(x);
            if size(f,1) > 1
                warning('too many output,we only use the first one');
                f = f(1);
            end
        end
        
       %% constructed function
        function obj = func_handle(specific)
            % specific 
            % please input column vector
            if ~exist('specific','var')
                specific = [];  % �����ʼ��?            
            end
            if ~isfield(specific,'Xdim') specific.Xdim = 30;  end % ����ά��
            if ~isfield(specific,'Xmin') specific.Xmin = -100*ones(specific.Xdim,1); end  % �½� 
            if ~isfield(specific,'Xmax') specific.Xmax = 100*ones(specific.Xdim,1);  end   % �Ͻ�
            if ~isfield(specific,'Fmin') specific.Fmin = 0;  end  % Ŀ�꺯����Сֵ
            if ~isfield(specific,'Tex')  specific.Tex  = 'This is a function_handle';  end   % ����tex����?            if ~isfield(specific,'Nobj') specific.Nobj = 1;  end  % Ŀ�꺯��ֵ����
            if ~isfield(specific,'Fneq') specific.Fneq = 0;  end  % ����ʽԼ��g
            if ~isfield(specific,'Feq')  specific.Feq  = 0;  end  % ��ʽԼ��h
            obj = obj@func_class(specific);
        end
   end
end