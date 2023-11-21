function AntecedentExperiment()
    % 分隔符
    delimiterIn = ' ';
    demoText = importdata("demo.m",delimiterIn);
    demoText = cell(demoText);
    % 创建一个收纳记数的
    NameCell = {};
    NumberCell = {};
    TimeCell = {};
    PlaceCell = {};
    for i = 1:length(demoText)
        line = strsplit(demoText{i});
        EHName = line{1};
        EHTime = join([line{2},"-",line{3}],"");
        EHPlace = line{4};
        if ismember(EHName,NameCell)
            place = find(strcmp(NameCell, EHName));
            NumberCell{place} = NumberCell{place}+1;
        else
            NameCell{end+1} = EHName;
            NumberCell{end+1} = 1;
            TimeCell{end+1} = EHTime;
            PlaceCell{end+1} = EHPlace;
        end
    end
    for i = 1:length(NameCell)
        disp(NameCell{i});
        disp(NumberCell{i});
        disp(TimeCell{i});
        disp(PlaceCell{i});
        disp("_____________________");
    end
    
end
