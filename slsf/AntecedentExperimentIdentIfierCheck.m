function AntecedentExperimentIdentIfierCheck()
    %0.参数记录与配置
    difffile = fopen('difffile.txt','a+');
    identifierCell = ["Simulink:SampleTime:InvHybridIfactionSS",
        "SimulinkBlocks:PropagationDelay:InputDelayMustBePositive",
        "Simulink:Engine:BlkWithPortInLoop",
        "Simulink:Engine:DefaultDimsMightHaveCausedError",
        "SimulinkFixedPoint:util:fxpParameterOverflow",
        "SimulinkBlocks:PropagationDelay:InputDelayNotFinite",
        "Simulink:DataType:PropForwardDataTypeError",
        "Simulink:blocks:PortValidationInputError",
        "Simulink:Engine:UnableToSolveAlgLoop",
        "Simulink:blocks:InvActSubsysConnection",
        "Simulink:Engine:BlkInAlgLoopErr"];
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
                    tag = false;
                    for i = 1:numel(identifierCell)
                        if contains(identifierCell{i},e.identifier)
                            identifierCell{i} = [];
                            identifierCell{end+1} = e.identifier;
                            identifierCell(cellfun(@isempty,identifierCell))=[];
                            tag = true;
                            break;
                        end
                    end
                    resultpath = replace(slxfilepath,"\","/"); 
                    if tag
                        % then
                        switch e.identifier
                            case identifierCell{1}
                                messageDiffMessage = sprintf("%s%s%s",resultpath,"这个存在identifier问题",e.identifier);
                                fprintf(difffile,messageDiffMessage);
                                fprintf(difffile,'\n');
                            case identifierCell{2}
                                messageDiffMessage = sprintf("%s%s%s",resultpath,"这个存在identifier问题",e.identifier);
                                fprintf(difffile,messageDiffMessage);
                                fprintf(difffile,'\n');
                            case identifierCell{3}
                                messageDiffMessage = sprintf("%s%s%s",resultpath,"这个存在identifier问题",e.identifier);
                                fprintf(difffile,messageDiffMessage);
                                fprintf(difffile,'\n');
                            case identifierCell{4}
                                messageDiffMessage = sprintf("%s%s%s",resultpath,"这个存在identifier问题",e.identifier);
                                fprintf(difffile,messageDiffMessage);
                                fprintf(difffile,'\n');
                            case identifierCell{5}
                                messageDiffMessage = sprintf("%s%s%s",resultpath,"这个存在identifier问题",e.identifier);
                                fprintf(difffile,messageDiffMessage);
                                fprintf(difffile,'\n');
                            case identifierCell{6}
                                messageDiffMessage = sprintf("%s%s%s",resultpath,"这个存在identifier问题",e.identifier);
                                fprintf(difffile,messageDiffMessage);
                                fprintf(difffile,'\n');
                            case identifierCell{7}
                                messageDiffMessage = sprintf("%s%s%s",resultpath,"这个存在identifier问题",e.identifier);
                                fprintf(difffile,messageDiffMessage);
                                fprintf(difffile,'\n');
                            case identifierCell{8}
                                messageDiffMessage = sprintf("%s%s%s",resultpath,"这个存在identifier问题",e.identifier);
                                fprintf(difffile,messageDiffMessage);
                                fprintf(difffile,'\n');
                            case identifierCell{9}
                                messageDiffMessage = sprintf("%s%s%s",resultpath,"这个存在identifier问题",e.identifier);
                                fprintf(difffile,messageDiffMessage);
                                fprintf(difffile,'\n');
                            case identifierCell{10}
                            otherwise
                                messageDiffMessage = sprintf("%s%s%s",resultpath,"这个存在问题",e.identifier);
                                fprintf(difffile,messageDiffMessage);
                                fprintf(difffile,'\n');
                        end
                    else
                        messageDiffMessage = sprintf("%s%s%s",resultpath,"这是一个全新的类型",e.identifier);
                        fprintf(difffile,messageDiffMessage);
                        fprintf(difffile,'\n');
                    end
                end
                % 关闭模型
                close_system(slxfilepath);
                % 加速模式
                simargs.SimulationMode='accelerator';
                try
                    sim(slxfilepath, simargs);
                catch e
                    tag = false;
                    for i = 1:numel(identifierCell)
                        if contains(identifierCell{i},e.identifier)
                            identifierCell{i} = [];
                            identifierCell{end+1} = e.identifier;
                            identifierCell(cellfun(@isempty,identifierCell))=[];
                            tag = true;
                            break;
                        end
                    end
                    resultpath = replace(slxfilepath,"\","/"); 
                    if tag
                        % then
                        switch e.identifier
                            case identifierCell{1}
                                messageDiffMessage = sprintf("%s%s%s",resultpath,"这个存在identifier问题",e.identifier);
                                fprintf(difffile,messageDiffMessage);
                                fprintf(difffile,'\n');
                            case identifierCell{2}
                                messageDiffMessage = sprintf("%s%s%s",resultpath,"这个存在identifier问题",e.identifier);
                                fprintf(difffile,messageDiffMessage);
                                fprintf(difffile,'\n');
                            case identifierCell{3}
                                messageDiffMessage = sprintf("%s%s%s",resultpath,"这个存在identifier问题",e.identifier);
                                fprintf(difffile,messageDiffMessage);
                                fprintf(difffile,'\n');
                            case identifierCell{4}
                                messageDiffMessage = sprintf("%s%s%s",resultpath,"这个存在identifier问题",e.identifier);
                                fprintf(difffile,messageDiffMessage);
                                fprintf(difffile,'\n');
                            case identifierCell{5}
                                messageDiffMessage = sprintf("%s%s%s",resultpath,"这个存在identifier问题",e.identifier);
                                fprintf(difffile,messageDiffMessage);
                                fprintf(difffile,'\n');
                            case identifierCell{6}
                                messageDiffMessage = sprintf("%s%s%s",resultpath,"这个存在identifier问题",e.identifier);
                                fprintf(difffile,messageDiffMessage);
                                fprintf(difffile,'\n');
                            case identifierCell{7}
                                messageDiffMessage = sprintf("%s%s%s",resultpath,"这个存在identifier问题",e.identifier);
                                fprintf(difffile,messageDiffMessage);
                                fprintf(difffile,'\n');
                            case identifierCell{8}
                                messageDiffMessage = sprintf("%s%s%s",resultpath,"这个存在identifier问题",e.identifier);
                                fprintf(difffile,messageDiffMessage);
                                fprintf(difffile,'\n');
                            case identifierCell{9}
                                messageDiffMessage = sprintf("%s%s%s",resultpath,"这个存在identifier问题",e.identifier);
                                fprintf(difffile,messageDiffMessage);
                                fprintf(difffile,'\n');
                            case identifierCell{10}
                            otherwise
                                messageDiffMessage = sprintf("%s%s%s",resultpath,"这个存在问题",e.identifier);
                                fprintf(difffile,messageDiffMessage);
                                fprintf(difffile,'\n');
                        end
                    else
                        messageDiffMessage = sprintf("%s%s%s",resultpath,"这是一个全新的类型",e.identifier);
                        fprintf(difffile,messageDiffMessage);
                        fprintf(difffile,'\n');
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
