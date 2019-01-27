classdef f9 < func_class 
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
            f1 = sum(x.^2)/30;
            f1 = -20*exp(-0.2*sqrt(f1));
            f2 = sum(cos(2*pi*x))/length(x);
            f2 = exp(f2);
            f = f1 - f2 + 20 + exp(1);
        end
        
       %% ���캯�� constructed function
        function obj = f9(specific)
            % specific Ԥ��ֵ,ʹ�ýṹ����,���ڴ��ݶ���Ĳ���
            % ���ú���������Ĭ��ֵ
                if ~exist('specific','var')
                    specific = [];  % ������ʼ��
                end
                if ~isfield(specific,'Xdim') specific.Xdim = 30;  end % ����ά��
                if ~isfield(specific,'Xmin') specific.Xmin = -5.12*ones(specific.Xdim,1); end  % �½� 
                if ~isfield(specific,'Xmax') specific.Xmax = 5.12*ones(specific.Xdim,1);  end   % �Ͻ�
                if ~isfield(specific,'Fmin') specific.Fmin = 0;  end  % Ŀ�꺯����Сֵ
                if ~isfield(specific,'Tex')  specific.Tex  =  '-20\exp\left[-0.2\sqrt{\frac{1}{D}\sum\limits_{i=1}^Dx_i^2}\right]-\exp\left(\frac{1}{D}\sum_{i=1}^D\cos(2\pix_i)\right)';   end   % ����tex���ʽ
                if ~isfield(specific,'Nobj') specific.Nobj = 1;  end  % Ŀ�꺯��ֵ����
                if ~isfield(specific,'Fneq') specific.Fneq = 0;  end  % ����ʽԼ��
                if ~isfield(specific,'Feq')  specific.Feq  = 0;  end  % ��ʽԼ��
            obj = obj@func_class(specific);
        end
   end
end    
