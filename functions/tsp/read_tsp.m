function [citys] = read_tsp(fname)
    fid = fopen(['./functions/tsp/data/' fname]);
    if fid < 0
       error('Can not read file!'); 
    end
    citys  = [];
    line = 0;
    while ~feof(fid)                                      % �ж��Ƿ�Ϊ�ļ�ĩβ               
        tline = fgetl(fid);                                 % ���ļ�����
        if line >= 6
    %         if(tline(1) ~= 'EOF')
            if(~strcmp(tline,'EOF'))
                num = str2num(tline);
                citys = [citys ; num(2:3) ];
            end
        end
        line = line+1;
    end
    fclose(fid);
end