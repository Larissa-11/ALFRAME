classdef  KUR < func_class 
%**************************************************************************
% References
    % [1] *Kalyanmoy Deb, Amrit Pratap, Sameer Agarwal, and T. Meyarivan*, |A Fast
    % Elitist Multiobjective Genetic Algorithm: NSGA-II|, IEEE Transactions on 
    % Evolutionary Computation 6 (2002), no. 2, 182 ~ 197.
    % [2] *N. Srinivas and Kalyanmoy Deb*, |Multiobjective Optimization Using 
    % Nondominated Sorting in Genetic Algorithms|, Evolutionary Computation 2 
    % (1994), no. 3, 221 ~ 248.
% Author  : unclear
% Adapter : Algori
% Email : zmdsn@126.com
% programmed: Sept 29, 2016
%**************************************************************************
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
            x1 = x(1:end-1);
            x2 = x(2:end);
			f(1) = sum(-10*exp(-0.2.*sqrt(x1.^2+x2.^2)));
            f(2) = sum(abs(x).^0.8+5*sin(x.^3));
        end
        
       %% ���캯�� constructed function
        function obj = KUR(specific)
            % specific Ԥ��ֵ,ʹ�ýṹ����,���ڴ��ݶ���Ĳ���
            % ���ú���������Ĭ��ֵ
            if ~exist('specific','var')
                specific = [];  % ������ʼ��
            end
            if ~isfield(specific,'Xdim') specific.Xdim = 3;  end % ����ά��
            if ~isfield(specific,'Xmin') specific.Xmin = -5*ones(specific.Xdim,1); end  % �½� 
            if ~isfield(specific,'Xmax') specific.Xmax = 5*ones(specific.Xdim,1);  end   % �Ͻ�
            if ~isfield(specific,'Fmin') specific.Fmin = 0;  end  % Ŀ�꺯����Сֵ
            if ~isfield(specific,'Tex')  specific.Tex  = 'f_1(x)=x^2\\f_2(x)=(x-2)^2';  end   % ����tex���ʽ
            if ~isfield(specific,'Nobj') specific.Nobj = 2;  end  % Ŀ�꺯��ֵ����
            if ~isfield(specific,'Fneq') specific.Fneq = 0;  end  % ����ʽԼ��
            if ~isfield(specific,'Feq')  specific.Feq  = 0;  end  % ��ʽԼ��
            obj = obj@func_class(specific);
        end
   end
end