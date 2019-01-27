classdef cec14_f17  < func_class 
    methods       
        %% 主运算函数
        function  [f, g, h] = object_function(obj, x , specific )
            % 注意这里x为列变量
            g = zeros(obj.Fneq,1);
            h = zeros(obj.Feq,1);
            f = cec14_func(x,17);
        end
        %% 构造函数
        function obj = cec14_f17(specific)
            % 定义上下界以及维数
            % N = 3
            % p = [0.3,0.3,0.4]
            % g1 : Modified Schwefel's Function f9
            % g2 : Rastrigin’s Function f8
            % g3: High Conditioned Elliptic Function f1
            % specific 预留值,使用结构数组,用于传递额外的参数
            % 设置函数参数的默认值
            if ~exist('specific','var')
                specific = [];  % 参数初始化
            end
            if ~isfield(specific,'Xdim') specific.Xdim = 30;  end % 变量维数
            if ~isfield(specific,'Xmin') specific.Xmin = -100*ones(specific.Xdim,1); end  % 下界 
            if ~isfield(specific,'Xmax') specific.Xmax = 100*ones(specific.Xdim,1);  end   % 上界
            if ~isfield(specific,'Fmin') specific.Fmin = 0;  end  % 目标函数最小值
            if ~isfield(specific,'Tex')  specific.Tex  = 'Function expressions refer to reference.';  end   % 函数tex表达式
            if ~isfield(specific,'Nobj') specific.Nobj = 1;  end  % 目标函数值个数
            if ~isfield(specific,'Fneq') specific.Fneq = 0;  end  % 不等式约束
            if ~isfield(specific,'Feq')  specific.Feq  = 0;  end  % 等式约束
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
