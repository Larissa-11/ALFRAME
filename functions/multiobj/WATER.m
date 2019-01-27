classdef  WATER < func_class 
%**************************************************************************
% Abstract :  NSGAII
% δ���
%
% Author : Algori
% Date : 9/29/2106
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
            g = [];
            h = [];
            f = zeros(obj.Xdim,1);
			f(1) = 106780.37(x(2)+x(3)) + 61704.670;
            f(2) = 3000*x(1);
            f(3) = 3057002289*x(2)/(0.06*2289)^0.65;
            f(4) = ;
            f(5) = ;
        end
        
       %% ���캯�� constructed function
        function obj = WATER(specific)
            % specific Ԥ��ֵ,ʹ�ýṹ����,���ڴ��ݶ���Ĳ���
            % ���ú���������Ĭ��ֵ
            if ~exist('specific','var')
                specific = [];  % ������ʼ��
            end
            if ~isfield(specific,'Xdim') specific.Xdim = 3;  end % ����ά��
            if ~isfield(specific,'Xmin') specific.Xmin = -0.01*ones(specific.Xdim,1); end  % �½� 
            if ~isfield(specific,'Xmax') specific.Xmax = [0.45 0.10 0.10];  end   % �Ͻ�
            if ~isfield(specific,'Fmin') specific.Fmin = 0;  end  % Ŀ�꺯����Сֵ
            if ~isfield(specific,'Tex')  specific.Tex  = 'f_1(x)=x^2\\f_2(x)=(x-2)^2';  end   % ����tex���ʽ
            if ~isfield(specific,'Nobj') specific.Nobj = 5;  end  % Ŀ�꺯��ֵ����
            if ~isfield(specific,'Fneq') specific.Fneq = 0;  end  % ����ʽԼ��
            if ~isfield(specific,'Feq')  specific.Feq  = 0;  end  % ��ʽԼ��
            obj = obj@func_class(specific);
        end
   end
end