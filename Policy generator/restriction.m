function restriction_Index = restriction(Device_ID,Max_value,Min_value,Start_Time,End_Time)

restriction_Index = {};
for i = 1: size(Max_value,1)
    if strcmp(Max_value{i,1},'null') == 1 && strcmp(Min_value{i,1},'null') == 1 && strcmp(Start_Time{i,1},'null') == 1 && strcmp(End_Time{i,1},'null') == 1 && strcmp(Device_ID{i,1},'null') == 0
         restriction_Index{i} = 'restriction policy';
     else restriction_Index{i} = 'null';
     end
end
restriction_Index = restriction_Index';
end