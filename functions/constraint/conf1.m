classdef conf1 < func_class 
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
			[f, g, h] = mlbsuite(x, 0, 4, 'C04');
        end
        
       %% ���캯�� constructed function
        function obj = conf1(specific)
            % specific Ԥ��ֵ,ʹ�ýṹ����,���ڴ��ݶ���Ĳ���
            % ���ú���������Ĭ��ֵ
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
                if ~isfield(specific,'Feq')  specific.Feq  = 4;  end  % ��ʽԼ��
            obj = obj@func_class(specific);
        end
   end
end