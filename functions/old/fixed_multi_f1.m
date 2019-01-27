classdef fixed_multi_f1 < func_class 
   methods
        %% �����㺯��
        function  [y,g,h]= object_function(obj, x , specific )
            % ע������xΪ�б���
            g = 0;
            h = 0;
            aa = [-32,-16,0,16,32,-32,-16,0,16,32,-32,-16,0,16,32,-32,-16,0,16,32,-32,-16,0,16,32;
               -32,-32,-32,-32,-32,-16,-16,-16,-16,-16,0,0,0,0,0,16,16,16,16,16,32,32,32,32,32];
            n = length(x);
            F = 0;  
            for j=1:25
                temp = j;
                for i=1:n
                   temp = temp +  power(x(i)-aa(i,j),6);
                end
                F = F + 1.0/temp;
            end
            F = F + 0.002;
            y = 1.0/F;
        end
       %% ���캯��
        function obj = fixed_multi_f1(specific)
            % �������½��Լ�ά��
            % �ǳ���Ȥ��һ������
            if ~exist('specific','var')
                specific = [];  % ������ʼ��
            end
            if ~isfield(specific,'Xdim') specific.Xdim = 2;  end % ����ά��
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