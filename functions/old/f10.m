classdef f10 < func_class 
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
            f = 0;  
            n = length(x);
            f1 = sum(x.^2)/4000;
            f2 = prod(cos(x'./sqrt(1:n)));
            f = f1 - f2 + 1;
        end
        
       %% ���캯�� constructed function
        function obj = f10(specific)
            % specific Ԥ��ֵ,ʹ�ýṹ����,���ڴ��ݶ���Ĳ���
            % ���ú���������Ĭ��ֵ
            if ~exist('specific','var')
                specific = [];  % ������ʼ��
            end
            if ~isfield(specific,'Xdim') specific.Xdim = 30;  end % ����ά��
            if ~isfield(specific,'Xmin') specific.Xmin = -32*ones(specific.Xdim,1); end  % �½� 
            if ~isfield(specific,'Xmax') specific.Xmax = 32*ones(specific.Xdim,1);  end   % �Ͻ�
            if ~isfield(specific,'Fmin') specific.Fmin = 0;  end  % Ŀ�꺯����Сֵ
            if ~isfield(specific,'Tex')  specific.Tex  =  'f=\frac{1}{4000}\sum\limits_{i=1}^Dx_i^2-\prod_{i=1}^D\cos\left(\frac{x_i}{\sqrt{i}}\right)';   end   % ����tex���ʽ
            if ~isfield(specific,'Nobj') specific.Nobj = 1;  end  % Ŀ�꺯��ֵ����
            if ~isfield(specific,'Fneq') specific.Fneq = 0;  end  % ����ʽԼ��
            if ~isfield(specific,'Feq')  specific.Feq  = 0;  end  % ��ʽԼ��
            obj = obj@func_class(specific);
        end
   end
end    
