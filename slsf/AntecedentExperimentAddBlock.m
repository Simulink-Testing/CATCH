function AntecedentExperimentAddBlock()
    warning("off");
    %0.参数记录与配置
    resultfile = fopen('resultfile.txt','a+');
    difffile = fopen('difffile.txt','a+');
    %1.获取指定文件夹下所有的文件夹
    filePath = sprintf("%s%s", pwd(), "/reportsneo");
    files_list = dir(fullfile(filePath,'*'));
    num_files = numel(files_list); % 获取文件夹中符合要求的文件个数
    for i = 1:num_files
        filename = files_list(i).name; % 获取文件名
        timefilepath = fullfile(files_list(i).folder, filename); % 获取文件路径
        % 2.找到文件夹
        if contains(filename,"202")
            % 3.找到errors文件夹
            filepath = sprintf("%s%s", timefilepath, "/errors");
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
                acceleratormessage = "";
                % 确认一下哪个模块有问题
                problemBlock = "";
                simargs.SimulationMode='normal';
                try
                    sim(slxfilepath, simargs);
                catch e
                    normalidentifier = e.identifier;
                    normalmessage = e.message;
                    if ~isempty(e.handles)
                        problemBlock = getfullname(e.handles{1});
                    end
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
                    resultslxfilepath = replace(slxfilepath,"\","/"); 
                    acceleratorResultMessage = sprintf("%s %s        %s", acceleratoridentifier, acceleratormessage,resultslxfilepath);
                    fprintf(resultfile,acceleratorResultMessage);
                    fprintf(resultfile,'\n');
                end
                % 关闭模型
                close_system(slxfilepath); 
                disp("有问题的模块是：");
                disp(problemBlock);
                % 对模型进行增加模块变化
                if problemBlock ~=""
                    copyFilepath = sprintf("%s%s", timefilepath, "/comperrors");
                    copyStatus = copyfile(slxfilepath,copyFilepath);
                    % 复制成功
                    if copyStatus == 1
                        copyslxfilepath = fullfile(copyFilepath, slxfilename); % 获取文件路径
                        % 模型错误的模块
                        copyslxblockpath = fullfile(copyFilepath, problemBlock); % 获取文件路径
                        % 随机添加模块
                        try
                            disp("开始变异");
                            copypathdemo = replace(copyslxfilepath,".slx","");
                            copynamedemo = replace(copyslxblockpath,copypathdemo,replace(slxfilename,".slx",""));
                            % if ispc()
                            %     copysys = strsplit(copynamedemo,'\');
                            % else
                            %     copysys = strsplit(copynamedemo,'/');
                            % end
                            if ispc()
                                copysys = strsplit(copynamedemo,'\');
                            else
                                copysys = strsplit(copynamedemo,'/');
                            end
                            % copysys = strsplit(copynamedemo,'/');
                            if length(copysys) == 1
                                token = copysys;
                            else
                                for j = 1:length(copysys) -1
                                    if j ==1
                                        token = copysys{j};
                                    else                     
                                        token = [token,'/',copysys{j}];    
                                        % if ispc()       
                                        %     token = [token,'\',copysys{j}]; 
                                        % else
                                        %     token = [token,'/',copysys{j}];
                                        % end
                                    end
                                end
                            end 
                            copyslxfilepath = copypathdemo;
                            Name = problemBlock;
                            sys_path = token;
                            
                            disp("输入的参数是");
                            disp(copyslxfilepath);
                            disp(Name);
                            disp(sys_path);
                            addSignalBlockFromSystem(copyslxfilepath,Name,sys_path);
                            disp("变异完成");
                        catch e
                            disp("变异过程中产生的错误是：");
                            disp(e);
                            if ~isempty(e.cause)
                                disp(e.cause{1});
                            end
                            if copypathdemo == copyslxfilepath
                                save_system(copyslxfilepath,[],'OverwriteIfChangedOnDisk',true);
                                close_system(copyslxfilepath);
                            end
                        end
                        copynormalidentifier = "";
                        copyacceleratoridentifier = "";
                        copynormalmessage = "";
                        copyacceleratormessage = "";
                        % 复制出的文件在普通模式下运行
                        simargs.SimulationMode='normal';
                        try
                            sim(copyslxfilepath, simargs);
                        catch e
                            copynormalidentifier = e.identifier;
                            copynormalmessage = e.message;
                            resultslxfilepath = replace(copyslxfilepath,"\","/"); 
                            copynormalResultMessage = sprintf("%s %s        %s", copynormalidentifier, copynormalmessage,resultslxfilepath);
                            fprintf(resultfile,copynormalResultMessage);
                            fprintf(resultfile,'\n');
                        end
                        % 关闭模型
                        close_system(copyslxfilepath);
                        % 复制出的文件在加速模式下运行
                        simargs.SimulationMode='accelerator';
                        try
                            sim(copyslxfilepath, simargs);
                        catch e
                            copyacceleratoridentifier = e.identifier;
                            copyacceleratormessage = e.message;
                            resultslxfilepath = replace(copyslxfilepath,"\","/"); 
                            copynormalResultMessage = sprintf("%s %s        %s", copyacceleratoridentifier, copyacceleratormessage,resultslxfilepath);
                            fprintf(resultfile,copynormalResultMessage);
                            fprintf(resultfile,'\n');
                        end
                        % 关闭模型
                        close_system(copyslxfilepath);
                        % 判断复制出的文件标识符是否完全相同
                        if ~strcmp(copynormalidentifier, copyacceleratoridentifier)
                            copyslxfilepath = replace(copyslxfilepath,"\","/"); 
                            identifierDiffMessage = sprintf("%s%s",copyslxfilepath,"在普通模式下标识符不一致");
                            fprintf(difffile,identifierDiffMessage);
                            fprintf(difffile,'\n');
                        end
                        % 判断复制出的文件信息是否完全相同
                        if ~strcmp(copynormalmessage, copyacceleratormessage)
                            copyslxfilepath = replace(copyslxfilepath,"\","/"); 
                            messageDiffMessage = sprintf("%s%s",copyslxfilepath,"在普通模式下具体信息不一致");
                            fprintf(difffile,messageDiffMessage);
                            fprintf(difffile,'\n');
                        end
                        % 判断复制出的文件标识符与原模式是否完全相同
                        if ~strcmp(normalidentifier, copynormalidentifier)
                            copyslxfilepath = replace(copyslxfilepath,"\","/"); 
                            identifierDiffMessage = sprintf("%s%s    %d  %d",copyslxfilepath,"在EMI模式下标识符不一致",normalidentifier,normalidentifier);
                            fprintf(difffile,identifierDiffMessage);
                            fprintf(difffile,'\n');
                        end
                        % 判断复制出的文件信息与原模式是否完全相同
                        if ~strcmp(normalmessage, copynormalmessage)
                            copyslxfilepath = replace(copyslxfilepath,"\","/"); 
                            messageDiffMessage = sprintf("%s%s    %s     %s",copyslxfilepath,"在EMI模式下具体信息不一致",normalmessage,copyacceleratormessage);
                            fprintf(difffile,messageDiffMessage);
                            fprintf(difffile,'\n');
                        end
                    end
                end
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
            end
        end 
    end
    % 4.最后的最后关闭文件
    fclose(resultfile);
    fclose(difffile);
end 