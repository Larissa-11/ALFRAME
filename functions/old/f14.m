classdef f14  < func_class 
   methods
       %% �����㺯��
        function  [f, g, h] = object_function(obj, x , specific )
			swarmsize = size( x , 2 );
            if swarmsize > 1
            % ����һ����Ⱥ�ĺ���ֵ
				y = [];  
                for i = 1:swarmsize
                    y(i) = object_function(obj, x(:,i) );
                end
            else
				% ����һ�������ĺ���ֵ
                a=[0.1957,0.1947,0.1735,0.16,0.0844,0.0627,0.0456,0.0342,0.0323,0.0235,0.0246];
                b=1./[0.25,0.5,1,2,4,6,8,10,12,14,16];
                y = 0; n=length(a);
                for i=1:n
                   y = y + (a(i) - (x(1)*b(i)*(b(i) + x(2)))/(b(i)*(b(i)+x(3)) + x(4)))^2;
                end
            end    
            f = y;
            g = [];
            h = [];
        end
       %% ���캯��
%         function obj = f14(specific)
%             % �������½��Լ�ά��
%             specific.Xdim = 30;          %����ά��
%             specific.Xmin = -65.536*ones(specific.Xdim,1);   %�½�
%             specific.Xmax = 65.536*ones(specific.Xdim,1);  %�Ͻ�
%             obj = obj@func_class(specific);
%         end
        function obj = f14(specific)
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