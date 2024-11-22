function AntecedentExperimentResultCheck()
    %0.参数记录与配置
    resultfile = fopen('resultfile.txt','a+');
    difffile = fopen('difffile.txt','a+');
    %1.获取指定文件夹下所有的文件夹
    filePath = sprintf("%s%s", pwd(), "/reportsneo");
    files_list = dir(fullfile(filePath,'*'));
    num_files = numel(files_list); % 获取文件夹中符合要求的文件个数
    for i = 1:num_files
        filename = files_list(i).name; % 获取文件名
        filepath = fullfile(files_list(i).folder, filename); % 获取文件路径
        % 2.找到文件夹
        if contains(filename,"202")
            % 3.找到errors文件夹
            filepath = sprintf("%s%s", filepath, "/errors");
            slxfiles_list = dir(fullfile(filepath,'*.slx'));
            num_slxfiles = numel(slxfiles_list); % 获取文件夹中符合要求的文件个数
            for k = 1:num_slxfiles
                Go = sprintf("正在执行%s文件夹内的模型：%d/%d", filepath, k, num_slxfiles);
                disp(Go);
                slxfilename = slxfiles_list(k).name; % 获取文件名
                slxfilepath = fullfile(slxfiles_list(k).folder, slxfilename); % 获取文件路径
                normalidentifier = "";
                acceleratoridentifier = "";
                normalmessage = "";
                normalhandles = 0;
                acceleratorhandles = 0;
                acceleratormessage = "";
                simargs.SimulationMode='normal';
                try
                    sim(slxfilepath, simargs);
                catch e
                    normalidentifier = e.identifier;
                    normalmessage = e.message;
                    if ~isempty(e.handles)
                        normalhandles = e.handles{1};
                    end
                    % normalhandles = e.handles{1};
                    resultslxfilepath = replace(slxfilepath,"\","/"); 
                    normalresultMessage = sprintf("%s %s       %s", normalidentifier, normalmessage,resultslxfilepath);
                    fprintf(resultfile,normalresultMessage);
                    fprintf(resultfile,'\n');
                end
                % 关闭模型
                close_system(slxfilepath);
                simargs.SimulationMode='accelerator';
                try
                    sim(slxfilepath, simargs);
                catch e
                    acceleratoridentifier = e.identifier;
                    acceleratormessage = e.message;
                    if ~isempty(e.handles)
                        acceleratorhandles = e.handles{1};
                    end
                    resultslxfilepath = replace(slxfilepath,"\","/"); 
                    acceleratorResultMessage = sprintf("%s %s        %s", acceleratoridentifier, acceleratormessage,resultslxfilepath);
                    fprintf(resultfile,acceleratorResultMessage);
                    fprintf(resultfile,'\n');
                end
                % 关闭模型
                close_system(slxfilepath);
                % 判断标识符是否完全相同
                if ~strcmp(normalidentifier, acceleratoridentifier)
                    slxfilepath = replace(slxfilepath,"\","/"); 
                    identifierDiffMessage = sprintf("%s%s",slxfilepath,"在不同模式下标识符不一致");
                    fprintf(difffile,identifierDiffMessage);
                    fprintf(difffile,'\n');
                end
                % 判断信息是否完全相同
                if ~strcmp(normalmessage, acceleratormessage)
                    slxfilepath = replace(slxfilepath,"\","/"); 
                    messageDiffMessage = sprintf("%s%s",slxfilepath,"在不同模式下具体信息不一致");
                    fprintf(difffile,messageDiffMessage);
                    fprintf(difffile,'\n');
                end
                % % 判断错误的block是否完全相同
                % if ~strcmp(normalBugBlock, acceleratorBugBlock)
                %     slxfilepath = replace(slxfilepath,"\","/"); 
                %     messageDiffMessage = sprintf("%s%s",slxfilepath,"在不同模式下发生错误的模块不一致");
                %     fprintf(difffile,messageDiffMessage);
                %     fprintf(difffile,'\n');
                % end
                % 判断错误的block句柄是否完全相同
                if ~isequal(normalhandles,acceleratorhandles)
                    slxfilepath = replace(slxfilepath,"\","/"); 
                    messageDiffMessage = sprintf("%s%s  %d %d",slxfilepath,"在不同模式下发生错误的模块句柄不一致",normalhandles,acceleratorhandles);
                    fprintf(difffile,messageDiffMessage);
                    fprintf(difffile,'\n');
                end
            end
        end  
    end
    % 4.最后的最后关闭文件
    fclose(resultfile);
    fclose(difffile);
end 