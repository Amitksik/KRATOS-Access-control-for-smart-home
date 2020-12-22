clear all

Raw_user_list = GetGoogleSpreadsheet('103c1f4R0JT7MoLXW_OhHKm8dgkqc_FWxmYZnnPhxr4c','0');
Raw_user_list(:,1)=[];
Header_row = Raw_user_list(1,:);
Policy_Index = strcmp(Raw_user_list(1,:),'Policy ID');
Policy_ID = Raw_user_list(:,Policy_Index);
Dummy_header = 'header';
Conflict = {};
Conflict{1} = 'Message';
for i=1:(size(Policy_ID,1)-1)
    Conflict{i+1} = 'null';
end
policy_decision = cat(2,Policy_ID,Conflict');


%%%%%%%%%%% User addition module %%%%%%%%%

User_List = usertable(Raw_user_list);
Final_user_list = user_list(User_List);


%%%%%%%%%%% Invalid User %%%%%%%%%%%%%%%%%




policy_decision = Invalid_check_User(Final_user_list,User_List,Raw_user_list,policy_decision);
policy_decision = Invalid_check_Admin(Final_user_list,User_List,Raw_user_list,policy_decision);
update_table = update_decision(policy_decision,Raw_user_list);
update_table = cat(1,Header_row,update_table);


% %%%%%%%%%%% Policy Type %%%%%%%%%%%%%%%

[General_policy, User_policy] = policytable(update_table, Header_row);
General_policy_id = General_policy(:,1);
General_policy_id(1,:)=[];

%%%%%%%%%% Priority Check %%%%%%%%%%%%%%%%%%%%
[user_priority, admin_priority] = prioritycheck(User_policy,Final_user_list);
priority_decision = priority(user_priority, admin_priority);


Priority_conflict_index = strcmp(priority_decision(:,1),'conflict found');
User_Policy_Index = strcmp(User_policy(1,:),'Policy ID');
User_policy_ID = User_policy(:,User_Policy_Index);
Conflicted_priority = User_policy_ID(Priority_conflict_index,:);
for i=1:size(Conflicted_priority,1)
user = strcmp(Policy_ID(:,1),Conflicted_priority(i));
policy_decision{user,2} = 'Low priority for policy';
end

%%%%%%%%% General Policy Check %%%%%%%%%%%%%%%%%

General_policy_decision = general_policy_check(General_policy,Final_user_list);
General_Conflict_index = strcmp(General_policy_decision(:,1),'conflict found');
General_Policy_Index = strcmp(General_policy(1,:),'Policy ID');
General_policy_ID = General_policy(:,General_Policy_Index);
Conflicted_priority = General_policy_ID(General_Conflict_index,:);
for i=1:size(Conflicted_priority,1)
user = strcmp(Policy_ID(:,1),Conflicted_priority(i));
policy_decision{user,2} = 'Low priority for general policy';
end


%%%%%%%%% Policy Table Update %%%%%%%%%%%%%%%%%%%%

Conflict_Index = strcmp(policy_decision(:,2),'null');
update_table = Raw_user_list(Conflict_Index,:);
update_table = cat(1,Header_row,update_table);

%%%%%%%%%%% Restriction Policy %%%%%%%%%%%%%%%%%%%%%
Device_ID_Index = strcmp(update_table(1,:),'Device ID');
Min_value_index = strcmp(update_table(1,:),'Brightness Min');
Max_value_index = strcmp(update_table(1,:),'Brightness Max');
start_time_index = strcmp(update_table(1,:),'Start Time');
end_time_index = strcmp(update_table(1,:),'End Time');
Device_ID = update_table(:,Device_ID_Index);
Min_value = update_table(:,Min_value_index);
Max_value = update_table(:,Max_value_index);
Start_Time = update_table(:,start_time_index);
End_Time = update_table(:,end_time_index);
Device_ID(1,:)=[]; 
Max_value(1,:)=[];
Min_value(1,:)=[];
Start_Time(1,:)=[];
End_Time(1,:)=[];
restriction_Index = restriction(Device_ID,Max_value,Min_value,Start_Time,End_Time);
restriction_policy_index = strcmp(restriction_Index(:,1),'restriction policy');
Copy = update_table;
Copy(1,:)=[];
Restriction_Policy_Table = Copy(restriction_policy_index,:);
Restriction_Policy_Table = cat(1,Header_row,Restriction_Policy_Table);
Restriction_policy_decision = general_policy_check(Restriction_Policy_Table,Final_user_list);
Restriction_Conflict_index = strcmp(Restriction_policy_decision(:,1),'conflict found');
Restriction_Policy_Index = strcmp(Restriction_Policy_Table(1,:),'Policy ID');
Restriction_policy_ID = Restriction_Policy_Table(:,Restriction_Policy_Index);
Restriction_Conflicted_priority = Restriction_policy_ID(Restriction_Conflict_index,:);
for i=1:size(Restriction_Conflicted_priority,1)
user = strcmp(Policy_ID(:,1),Restriction_Conflicted_priority(i));
policy_decision{user,2} = 'Low priority for restriction policy';
end

% %%%%%%%%% Value Policy %%%%%%%%%%%%%%%%%%%%%%%%%%%

Value_Index = {};
for i = 1: size(Max_value,1)
    if strcmp(Max_value{i,1},'null') == 0 || strcmp(Min_value{i,1},'null') == 0
        Value_Index{i} = 'value policy';
    else Value_Index{i} = 'null';
    end
end
Value_Index = Value_Index';
Value_policy_index = strcmp(Value_Index(:,1),'value policy');
Copy = update_table;
Copy(1,:)=[];
Value_Policy_Table = Copy(Value_policy_index,:);
Value_Policy_Table = cat(1,Header_row,Value_Policy_Table);

Device_ID_Index = strcmp(Value_Policy_Table(1,:),'Device ID');
Device_ID = Value_Policy_Table(:,Device_ID_Index);
Device_ID(1,:)=[];
Device_list = unique(Device_ID);
tf = isempty(Device_list);
if tf == 0
k = find(Device_ID_Index);
Value_Policy_Index = strcmp(Value_Policy_Table(:,k), Device_list(1));
Value_policy = Value_Policy_Table(Value_Policy_Index,:);
All_Value_policy = cat(1,Header_row,Value_policy);
Min_brightness = str2double(Value_policy(:,Min_value_index));
Max_brightness = str2double(Value_policy(:,Max_value_index));
Index = find(ismember(Value_policy(:,1), General_policy_id));
tf = isempty(Index);
General_value_policy = Value_policy(Index,:);
Restrict_value_policy = Value_policy;
Restrict_value_policy(Index,:) = [];
General_max_brightness = Max_brightness(Index);
General_min_brightness = Min_brightness(Index);
Number_of_policies = size(Restrict_value_policy,1);
Decision = {};
for i = 1:Number_of_policies
X1 = find(Min_value_index);
X2 = find(Max_value_index);
Restrict_min = str2double(Restrict_value_policy(i,X1));
Restrict_max = str2double(Restrict_value_policy(i,X2));
if General_max_brightness > Restrict_max && General_min_brightness < Restrict_min
    Decision{i} = 'no value conflict';
else 
    Decision{i} = 'value conflict';
end
end
Decision = Decision';

Decision = cat(1,Dummy_header,Decision);
Restrict_value_policy = cat(1,Header_row,Restrict_value_policy);
Value_Conflict_index = strcmp(Decision(:,1),'value conflict');
Value_Policy_Index = strcmp(Restrict_value_policy(1,:),'Policy ID');
Restriction_value_ID = Restrict_value_policy(:,Value_Policy_Index);
value_Conflicted_policy = Restriction_value_ID(Value_Conflict_index,:);
for i=1:size(value_Conflicted_policy,1)
user = strcmp(Policy_ID(:,1),value_Conflicted_policy(i));
policy_decision{user,2} = 'Value conflicted with general policy';
end
end

% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Time Policy  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
Time_Index = {};
for i = 1: size(Start_Time,1)
    if strcmp(Start_Time{i,1},'null') == 0 || strcmp(End_Time{i,1},'null') == 0
        Time_Index{i} = 'time policy';
    else Time_Index{i} = 'null';
    end
end
Time_Index = Time_Index';
Time_policy_index = strcmp(Time_Index(:,1),'time policy');
Copy2 = update_table;
Copy2(1,:)=[];
Time_Policy_Table = Copy2(Time_policy_index,:);
Time_Policy_Table = cat(1,Header_row,Time_Policy_Table);
Device_ID_Index1 = strcmp(Time_Policy_Table(1,:),'Device ID');
Device_ID1 = Time_Policy_Table(:,Device_ID_Index1);
Device_ID1(1,:)=[];
Device_list1 = unique(Device_ID1);
tf2 = isempty(Device_list1);
if tf2 == 0
Time_Policy_Index = strcmp(Time_Policy_Table(:,k), Device_list1(1));

Time_policy = Time_Policy_Table(Time_Policy_Index,:);
All_Time_policy = cat(1,Header_row,Time_policy);
Index1 = find(ismember(Time_policy(:,1), General_policy_id));
tf1 = isempty(Index1);
Start_Time = Time_policy(:,start_time_index);
End_Time = Time_policy(:,end_time_index);
Hr_start = [];
Hr_end = [];
Min_start = [];
Min_end = [];

for i = 1:size(Start_Time,1)
    [Hr_start(i), Hr_end(i), Min_start(i), Min_end(i)] = time(Start_Time(i),End_Time(i));
    
end

Time_policy_ID = Time_policy(:,1);
General_time_policy = Time_policy(Index1,:);
Restrict_time_policy = Time_policy;
Restrict_time_policy(Index1,:) = [];
General_Hr_start = Hr_start(Index1);
General_Min_start = Min_start(Index1);
General_Hr_end = Hr_end(Index1);
General_Min_end = Min_end(Index1);
Number_of_policies = size(Restrict_time_policy,1);
Decision1 = {};
General_policy_range = timerange(General_Hr_start,General_Hr_end);


for i = 1:Number_of_policies
Policy_start_hr = Hr_start(i+1);
Policy_end_hr = Hr_end(i+1);
Policy_start_min = Min_start(i+1);
Policy_end_min = Min_end(i+1);
Start = find(ismember(General_policy_range, Policy_start_hr));
start_index = isempty(Start);
End = find(ismember(General_policy_range, Policy_end_hr));
end_index = isempty(End);
if start_index == 0 && end_index == 0
    if Policy_start_min >= General_Min_start || Policy_start_min == 0
        if Policy_end_min <= General_Min_start || Policy_end_min == 0
    Decision1{i} = 'no time conflict';
        end
    end
else 
    Decision1{i} = 'time conflict';
end
end
Decision1 = Decision1';
Decision1 = cat(1,Dummy_header,Decision1);
Restrict_time_policy = cat(1,Header_row,Restrict_time_policy);
Time_Conflict_index = strcmp(Decision1(:,1),'time conflict');
Time_Policy_Index = strcmp(Restrict_time_policy(1,:),'Policy ID');
Restriction_time_ID = Restrict_time_policy(:,Time_Policy_Index);
time_Conflicted_policy = Restriction_time_ID(Time_Conflict_index,:);
for i=1:size(time_Conflicted_policy,1)
user = strcmp(Policy_ID(:,1),time_Conflicted_policy(i));
policy_decision{user,2} = 'Time conflicted with general policy';
end
end

policy_decision = strrep(policy_decision, 'null', 'success');
status = mat2sheets('103c1f4R0JT7MoLXW_OhHKm8dgkqc_FWxmYZnnPhxr4c', '1940752161', [1 1], policy_decision);


