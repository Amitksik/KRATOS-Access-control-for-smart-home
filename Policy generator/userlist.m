clear all
% Raw_user_list = GetGoogleSpreadsheet('1_EDUc73X7fBPPWbNyCxWPdFIvPegQ9qwrlnQyq1frz8','0');
% Raw_row = size(Raw_user_list,1);
% user_list = GetGoogleSpreadsheet('1_EDUc73X7fBPPWbNyCxWPdFIvPegQ9qwrlnQyq1frz8','0');
% user_list([1],:) = []; %%%Delete the first row (header row)
% user_list(:,1) = [];   %%%Delete the first column (Time column)
% 
% Row = size(user_list,1);
% Column = size(user_list,2);
% 
% Final_user_list = GetGoogleSpreadsheet('1pglB7Y7r7I8c5n1UI55jVoqKZtDlRZXfiAb4juHeh90','1728085595');
% Final_row = size(Final_user_list,1);
% Check = [];
% New_user = user_list(Row,1);
% 
% 
% for i = 1:Final_row
% A = Final_user_list(i,1);
% tf = strcmp(New_user,A);
% Check(i) = tf;
% end
% B = any(Check(:) == 1);
% 
% 
% if B == 1
%     message = {'user exist'};
%     status = mat2sheets('1pglB7Y7r7I8c5n1UI55jVoqKZtDlRZXfiAb4juHeh90', '0', [2 1], message);
%     
%     
% elseif B == 0
% user_priority = [];
% added_user = user_list(Row,2);
% for i = 1:Final_row
% A = Final_user_list(i,1);
% tf = strcmp(added_user,A);
% user_priority(i) = tf;
% end
% 
% k = find(user_priority);
% 
% Added_priority = Final_user_list(k,2);
% Admin_priority = str2double(Added_priority);
% New_user_priority = str2double(user_list(Row,3));
% 
% if Admin_priority > New_user_priority
%     message = {'priority conflict found'};
%     status = mat2sheets('1pglB7Y7r7I8c5n1UI55jVoqKZtDlRZXfiAb4juHeh90', '0', [2 1], message);
% elseif Admin_priority <= New_user_priority
%     message = {'user added successfully'};
%     status = mat2sheets('1pglB7Y7r7I8c5n1UI55jVoqKZtDlRZXfiAb4juHeh90', '0', [2 1], message);
%     New_add = user_list([Row],:);
%     New_add(:,2) = [];
%     Final_user_list = cat(1, Final_user_list, New_add);
%     status = mat2sheets('1pglB7Y7r7I8c5n1UI55jVoqKZtDlRZXfiAb4juHeh90', '1728085595', [1 1], Final_user_list);
%     
% end
% end
% 
% 
% 
% 
% % message = {'user exist'};
% % status = mat2sheets('1pglB7Y7r7I8c5n1UI55jVoqKZtDlRZXfiAb4juHeh90', '0', [2 1], message);

Value1 = 100;
Value2 = 1000;
Value_range = [Value1:Value2];
Lia = ismember(101,Value_range)

% Value_1 = B(:,5);
% Value_2 = B(:,6);
% Value_max = str2double(Value_1);
% Value_min = str2double(Value_2);
% 
% 
% Value_range_table = cell(1,size(B,1));
% for i=1:size(B,1)    
%     Value_range = [Value_min(i):Value_max(i)];
%     Value_range_table{i}=Value_range;
% end
% 
% r=checkmatrix_value(Value_range_table);
% value_policy = cell(size(r,1),1);
% for i=1:size(r,1)
%     for j = 1: size(r,2)
%         if i~=j && r(i,j)==1         
%          B = cellstr(sprintf('%s has value conflict with %s', C{i},C{j}));
%          s = ' ';
%          value_policy(i) = strcat(value_policy(i),s, B);
%         end
%     end
%     
%     
%     
%     
% end
% A=value_policy;
