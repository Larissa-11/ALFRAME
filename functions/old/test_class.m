classdef test_class < mobjfunc_class 
   methods
       %% �����㺯��
        function  y = fun_fitness(obj, x , specific )
            % ע������xΪ�б���
            % specific Ԥ��ֵ,����ʹ�ýṹ����,���ڴ��ݶ���Ĳ���
            swarmsize = size( x , 2 );
            if swarmsize > 1
            % ����һ����Ⱥ�ĺ���ֵ
				y = zeros(swarmsize,obj.objNum);  
                for i = 1:swarmsize
                    y(i,:) = fun_fitness(obj, x(:,i) );
                end
            else
            % ����һ�������ĺ���ֵ
                y = [];
                x = x';
                V = obj.Xdim;
                temp = x(:,3:V); 
                g = 9*sum(temp)/(V-2);
                y(1) = x(1);
                y(2) = x(2);
                h = 3 - y(1)*(1+sin(3*pi*y(1)))/(1+g) - y(2)*(1+sin(3*pi*y(2)))/(1+g);
                y(3) = (1+g)*h;
            end
            if size(y,2) ~= obj.objNum
                warning('The number of decision variables does not match . Kindly check your objective function')
            end
        end
        
       %% ���캯��
        function obj = test_class(in_spec)
            % ���캯�� ,����һ��������
            dimension = 30;  % ����ά��
            minimum = 0*ones(dimension,1); % �½� 
            maximum = 1*ones(dimension,1);  % �Ͻ�
            func_min = 0;
            obj_num = 3;
            specific.Tex = 'f=\sum\limits_{i=1}^D x_i^2';  % ����tex���ʽ
            switch nargin
                case 0
                    if length(obj_num) == 1 && obj_num > 1
                        specific.objNum = obj_num;
                    else
                        error('Please enter the correct parameters : objNum');
                    end
                    if length(dimension) == 1
                        specific.Xdim = dimension;
                    else
                        error('Please enter the correct parameters : Xdim');
                    end
                    if length(func_min) == 1
                        specific.Fmin = func_min;
                    else
                        error('Please enter the correct parameters : Fmin');
                    end
                    specific.Fmin = func_min;
                    if length(maximum) == 1 
                        specific.Xmin = maximum*ones(dimension,1);    % �Ͻ�    
                    else
                        specific.Xmax = maximum;    % �Ͻ�                        
                    end
                    if length(minimum) == 1 
                        specific.Xmin = minimum*ones(dimension,1);    % �½�    
                    else
                        specific.Xmin = minimum;    % �½�                        
                    end    
                case 1
                    if isfield(in_spec,'Xdim') 
                        if length(in_spec.Xdim) == 1
                            specific.Xdim = in_spec.Xdim;
                        else
                            error('Please enter the correct parameters : Xdim');
                        end
                    elseif exist('dimension')
                        specific.Xdim = dimension;
                    end
                    if isfield(in_spec,'Xmin')
                        if length(in_spec.Xmin) == 1
                            specific.Xmin = in_spec.Xmin*ones(in_spec.Xdim,1);
                        else
                            specific.Xmin = in_spec.Xmin;
                        end
                    else
                        if length(maximum) == 1 
                            specific.Xmin = maximum*ones(dimension,1);    % �Ͻ�    
                        else
                            specific.Xmax = maximum;    % �Ͻ�                        
                        end
                    end
                    if isfield(in_spec,'Xmax') 
                        if length(in_spec.Xmax) == 1
                            specific.Xmax = in_spec.Xmax*ones(in_spec.Xdim,1);
                        else
                            specific.Xmax = in_spec.Xmax;
                        end
                    else
                        if length(minimum) == 1 
                            specific.Xmin = minimum*ones(dimension,1);    % �½�    
                        else
                            specific.Xmin = minimum*ones(dimension,1);    % �½�                        
                        end                            
                    end
                    if isfield(in_spec,'objNum') 
                        if length(in_spec.objNum) == 1 && in_spec.objNum >= 1
                            specific.objNum = in_spec.objNum;
                        else
                            error('Please enter the correct parameters : objNum');
                        end
                    elseif exist('obj_num')
                        specific.objNum = obj_num;
                    end
                    if isfield(in_spec,'Fmin')
                        if length(in_spec.Fmin) == 1
                            specific.Fmin = in_spec.Fmin;
                        else
                            error('Please enter the correct parameters : Fmin');
                        end
                    elseif exist('func_min')
                        specific.Fmin = func_min;
                    end
            end
            obj = obj@mobjfunc_class(specific);
        end
   end
end