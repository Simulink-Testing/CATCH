function AntecedentExperimentThrowCheck()
    %0.参数记录与配置
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
                simargs.SimulationMode='normal';
                try
                    sim(slxfilepath, simargs);
                catch e
                    %3.1 throw
                    try
                        rethrow(e);
                    catch e2
                        % % 句柄不同
                        % if ~isequal(e.handles{1},e2.handles{1})
                        %     messageDiffMessage = sprintf("%s%s",slxfilepath,"在rethrow下发生错误的模块句柄不一致");
                        %     fprintf(difffile,messageDiffMessage);
                        %     fprintf(difffile,'\n');
                        % end
                        % 模块不同
                        % if ~strcmp(getfullname(e.handles{1}), getfullname(e2.handles{1}))
                        %     messageDiffMessage = sprintf("%s%s",slxfilepath,"在rethrow下发生错误的模块不一致");
                        %     fprintf(difffile,messageDiffMessage);
                        %     fprintf(difffile,'\n');
                        % end
                        % 标识符不同
                        if ~strcmp(e.identifier, e2.identifier)
                            messageDiffMessage = sprintf("%s%s",slxfilepath,"在rethrow下发生错误的标识符不一致");
                            fprintf(difffile,messageDiffMessage);
                            fprintf(difffile,'\n');
                        end
                        % 信息不同
                        if ~strcmp(e.message, e2.message)
                            messageDiffMessage = sprintf("%s%s",slxfilepath,"在rethrow下发生错误的模块句柄不一致");
                            fprintf(difffile,messageDiffMessage);
                            fprintf(difffile,'\n');
                        end
                    end
                    %3.2 rethrow
                    try 
                        throw(e);
                    catch e3
                        % % 句柄不同
                        % if ~isequal(e.handles{1},e3.handles{1})
                        %     messageDiffMessage = sprintf("%s%s",slxfilepath,"在throw下发生错误的模块句柄不一致");
                        %     fprintf(difffile,messageDiffMessage);
                        %     fprintf(difffile,'\n');
                        % end
                        % 模块不同
                        % if ~strcmp(getfullname(e.handles{1}), getfullname(e3.handles{1}))
                        %     messageDiffMessage = sprintf("%s%s",slxfilepath,"在throw下发生错误的模块不一致");
                        %     fprintf(difffile,messageDiffMessage);
                        %     fprintf(difffile,'\n');
                        % end
                        % 标识符不同
                        if ~strcmp(e.identifier, e3.identifier)
                            messageDiffMessage = sprintf("%s%s",slxfilepath,"在throw下发生错误的标识符不一致");
                            fprintf(difffile,messageDiffMessage);
                            fprintf(difffile,'\n');
                        end
                        % 信息不同
                        if ~strcmp(e.message, e3.message)
                            messageDiffMessage = sprintf("%s%s",slxfilepath,"在throw下发生错误的模块句柄不一致");
                            fprintf(difffile,messageDiffMessage);
                            fprintf(difffile,'\n');
                        end
                    end
                    %3.3 throwAsCaller
                    try 
                        throwAsCaller(e);
                    catch e4
                        % % 句柄不同
                        % if ~isequal(e.handles{1},e4.handles{1})
                        %     messageDiffMessage = sprintf("%s%s",slxfilepath,"在throwAsCaller下发生错误的模块句柄不一致");
                        %     fprintf(difffile,messageDiffMessage);
                        %     fprintf(difffile,'\n');
                        % end
                        % 模块不同
                        % if ~strcmp(getfullname(e.handles{1}), getfullname(e4.handles{1}))
                        %     messageDiffMessage = sprintf("%s%s",slxfilepath,"在throwAsCaller下发生错误的模块不一致");
                        %     fprintf(difffile,messageDiffMessage);
                        %     fprintf(difffile,'\n');
                        % end
                        % 标识符不同
                        if ~strcmp(e.identifier, e4.identifier)
                            messageDiffMessage = sprintf("%s%s",slxfilepath,"在throwAsCaller下发生错误的标识符不一致");
                            fprintf(difffile,messageDiffMessage);
                            fprintf(difffile,'\n');
                        end
                        % 信息不同
                        if ~strcmp(e.message, e4.message)
                            messageDiffMessage = sprintf("%s%s",slxfilepath,"在throwAsCaller下发生错误的模块句柄不一致");
                            fprintf(difffile,messageDiffMessage);
                            fprintf(difffile,'\n');
                        end
                    end       
                end
                % 关闭模型
                close_system(slxfilepath);
            end
        end  
    end
    % 4.最后的最后关闭文件
    fclose(difffile);
end 
