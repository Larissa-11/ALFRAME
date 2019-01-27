function [  ] = altest( algo , func , is_figure)
% �㷨���Ժ���
% algo �㷨����
% func ���Ժ���
    addroad;
%     clc; 
    
    %% ѡ���㷨
    algo_name = algo;
    % �����㷨����
    algo_config.PopuSize = 40;
    algo_config.maxFES = 60000;

    %% ѡ����Ժ���
    func_name = func;
    % func_name = 'mobjf1';
    
    % ���ú�������
    func_config.Xdim = 30; 

    % ����һ���㷨
    [best_fvalue,best_solution,run_series,run_info] = feval(algo_name,func_name,algo_config,func_config);
%     [best_solution,best_fvalue,run_series,run_info] = feval(algo_name,func_name,algo_config);
    if exist('is_figure','var')
        draw_data{1} = run_series;
        draw_lines(draw_data , 1, 1 , 1 ,[algo_name],1);
    end
    disp( ['  ************** ' algo_name ' ***************'] );
    disp(['      Best Value  =  ' num2str(best_fvalue,'%10.5e') ]);
    disp(['      Time Used   =  ' num2str(run_info) 's']);
end

