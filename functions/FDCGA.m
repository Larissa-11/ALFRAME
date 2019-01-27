classdef FDCGA < func_class 
    methods       
        %% �����㺯��
        function  [f, g, h] = object_function(obj, x , specific )
            % ע������xΪ�б���
            g = zeros(obj.Fneq,1);
            h = zeros(obj.Feq,1);
            x = x./sum(x);
            ff = zeros(1,3);
            parfor i = 1:3
                ff(i) = alGbest( 'HAF1' , 'cec15_f4',x);
            end
            f = mean(ff);
        end
        %% ���캯��
        function obj = FDCGA(specific)
            % specific Ԥ��ֵ,ʹ�ýṹ����,���ڴ��ݶ���Ĳ���
            % ���ú���������Ĭ��ֵ
            if ~exist('specific','var')
                specific = [];  % ������ʼ��
            end
            if ~isfield(specific,'Xdim') specific.Xdim = 3;  end % ����ά��
            if ~isfield(specific,'Xmin') specific.Xmin = 0*ones(specific.Xdim,1); end  % �½� 
            if ~isfield(specific,'Xmax') specific.Xmax = 1*ones(specific.Xdim,1);  end   % �Ͻ�
            if ~isfield(specific,'Fmin') specific.Fmin = 0;  end  % Ŀ�꺯����Сֵ
            if ~isfield(specific,'Tex')  specific.Tex  = 'Function expressions refer to reference.';  end   % ����tex���ʽ
            if ~isfield(specific,'Nobj') specific.Nobj = 1;  end  % Ŀ�꺯��ֵ����
            if ~isfield(specific,'Fneq') specific.Fneq = 0;  end  % ����ʽԼ��
            if ~isfield(specific,'Feq')  specific.Feq  = 0;  end  % ��ʽԼ��
            obj = obj@func_class(specific);
        end
    end
end
%**************************************************************************
% Reference :   
%   Liang J J, Qu B Y, Suganthan P N. Problem definitions and 
%   evaluation criteria for the CEC 2014 special session and competition 
%   on singl objective real-parameter numerical optimization[J]. 2013.
%**************************************************************************
