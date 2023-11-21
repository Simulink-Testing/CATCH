function last_Outport = addSignalBlockFromSystem(copyslxfilepath,Name,sys_path)
% 模型变异
sys = load_system(copyslxfilepath);
% 每层最大生成块数
GEN_NUM = 2;
% 生成层数
GEN_DEEPTH = 3;
% 获得该系统中的所有块
all_block = find_system(sys,'Type','Block');
all_blk_type = get_param(all_block,'BlockType');
% 去重
all_blk_type = unique(all_blk_type);
% 去掉一些不能生成的 SubSystem Outport To Workspace
all_blk_type(strcmp(all_blk_type,'Outport'))=[];
all_blk_type(strcmp(all_blk_type,'SubSystem'))=[];
all_blk_type(strcmp(all_blk_type,'ToWorkspace'))=[];
all_blk_type(strcmp(all_blk_type,'ActionPort'))=[];
all_blk_type(strcmp(all_blk_type,'S-Function'))=[];
% 获取具体名
for ko =1:length(all_blk_type)
    all_blk_type{ko} = getFullBlockTypeName(all_blk_type{ko});
end
% 生成一个块信号选择块
if strcmp(Name,sys_path)
    start_Name = strcat(Name,'/start');
else
    start_Name = strcat(Name,'_start');
end
% 生成这个块
add_block('simulink/Signal Routing/Manual Variant Sink',start_Name,'MakeNameUnique','on');
start_port = get_param(start_Name,'PortHandles');
% 连接她和首块 如果是在大系统下就不需要了
if ~strcmp(Name,sys_path)
    name_port = get_param(Name,'PortHandles');
    add_line(sys_path,name_port.Outport(1),start_port.Inport(1),'autorouting','on');
end
% 记录第一个块的名字
first_blk = start_Name;
% 根据层数生成
tree = {start_Name};
gen_num = randi(GEN_DEEPTH);
for i = 1:gen_num
    % 看看几个要生成的
    n_tree_list={};
    for j =1:length(tree)
        % 随机确定生成几个
        blk = tree{j};
        port = get_param(blk,'PortHandles');
        for w = 1:GEN_NUM
            % 随机生成一个
            new_blk = randomchoose(all_blk_type);
            nblk_Name = strcat(first_blk,'nzb','_',string(i),'_',string(j),'_',string(w));
            add_block(new_blk,nblk_Name);
            n_port = get_param(nblk_Name,'PortHandles');
            % 判断一下有没有Inport口
            while isempty(n_port.Inport)|| isempty(n_port.Outport)
                delete_block(nblk_Name);
                new_blk = randomchoose(all_blk_type);
                nblk_Name = strcat(first_blk,'nzb','_',string(i),'_',string(j),'_',string(w));
                add_block(new_blk,nblk_Name);
                n_port = get_param(nblk_Name,'PortHandles');
            end
            % 添加线
            
            if port.Outport(1) == start_port.Outport(1)
                add_line(sys_path,port.Outport(2),n_port.Inport(1),'autorouting','on');
            else
                add_line(sys_path,port.Outport(1),n_port.Inport(1),'autorouting','on');
            end
            n_tree_list{end+1} = nblk_Name(1,1);
            % 判断一下是否是If
            if contains(new_blk,'If')
                if_sub = strcat(nblk_Name,'if_sub');
                add_block('simulink/Ports & Subsystems/If Action Subsystem',if_sub);
                ifaction_port = get_param(if_sub,'PortHandles');
                add_line(sys_path,n_port.Outport(1),ifaction_port.Ifaction,'autorouting','on');
                nblk_Name = if_sub;
                n_tree_list{end} = nblk_Name;
            end
        end
    end
    tree = n_tree_list;
end
% 保存模型
save_system(sys);
% 随机选择块的方法
    function blk = randomchoose(all_blk_type)
        num = randi(length(all_blk_type));
        blk = all_blk_type{num};
    end
end

