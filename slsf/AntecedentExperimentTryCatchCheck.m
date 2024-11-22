function AntecedentExperimentTryCatchCheck()
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
                    % 正常情况，是不会触发下面的代码的
                    messageDiffMessage = sprintf("%s%s",slxfilepath,"模型在try/catch处存在继续执行的问题");
                    fprintf(difffile,messageDiffMessage);
                    fprintf(difffile,'\n');
                catch e
                    %3.1 throw
                    try
                        rethrow(e);
                        % 正常情况，是不会触发下面的代码的
                        messageDiffMessage = sprintf("%s%s",slxfilepath,"模型在rethrow try/catch处存在继续执行的问题");
                        fprintf(difffile,messageDiffMessage);
                        fprintf(difffile,'\n');
                    catch 
                    end
                    %3.2 rethrow
                    try 
                        throw(e);
                        % 正常情况，是不会触发下面的代码的
                        messageDiffMessage = sprintf("%s%s",slxfilepath,"模型在throw try/catch处存在继续执行的问题");
                        fprintf(difffile,messageDiffMessage);
                        fprintf(difffile,'\n');
                    catch   
                    end
                    %3.3 throwAsCaller
                    try 
                        throwAsCaller(e);
                        % 正常情况，是不会触发下面的代码的
                        messageDiffMessage = sprintf("%s%s",slxfilepath,"模型在throwAsCaller try/catch处存在继续执行的问题");
                        fprintf(difffile,messageDiffMessage);
                        fprintf(difffile,'\n');
                    catch   
                    end       
                end
                % 关闭模型
                close_system(slxfilepath);
                % 加速模式
                simargs.SimulationMode='accelerator';
                try
                    sim(slxfilepath, simargs);
                    % 正常情况，是不会触发下面的代码的
                    messageDiffMessage = sprintf("%s%s",slxfilepath,"模型在加速模式 try/catch处存在继续执行的问题");
                    fprintf(difffile,messageDiffMessage);
                    fprintf(difffile,'\n');
                catch e
                     %3.1 throw
                    try
                        rethrow(e);
                        % 正常情况，是不会触发下面的代码的
                        messageDiffMessage = sprintf("%s%s",slxfilepath,"模型在加速模式 rethrow try/catch处存在继续执行的问题");
                        fprintf(difffile,messageDiffMessage);
                        fprintf(difffile,'\n');
                    catch 
                    end
                    %3.2 rethrow
                    try 
                        throw(e);
                        % 正常情况，是不会触发下面的代码的
                        messageDiffMessage = sprintf("%s%s",slxfilepath,"模型在加速模式 throw try/catch处存在继续执行的问题");
                        fprintf(difffile,messageDiffMessage);
                        fprintf(difffile,'\n');
                    catch   
                    end
                    %3.3 throwAsCaller
                    try 
                        throwAsCaller(e);
                        % 正常情况，是不会触发下面的代码的
                        messageDiffMessage = sprintf("%s%s",slxfilepath,"模型在加速模式 throwAsCaller try/catch处存在继续执行的问题");
                        fprintf(difffile,messageDiffMessage);
                        fprintf(difffile,'\n');
                    catch   
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
