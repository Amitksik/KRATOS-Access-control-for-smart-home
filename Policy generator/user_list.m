function list = user_list(B)

user_list = B;
user_list(1,:) = []; %%%Delete the first row (header row)


Row = size(user_list,1);


Final_user_list = GetGoogleSpreadsheet('1pglB7Y7r7I8c5n1UI55jVoqKZtDlRZXfiAb4juHeh90','1728085595');
Final_row = size(Final_user_list,1);
Check = [];
New_user = user_list(Row,1);


for i = 1:Final_row
A = Final_user_list(i,1);
tf = strcmp(New_user,A);
Check(i) = tf;
end
B = any(Check(:) == 1);


if B == 1
    message = {'user exist'};
    status = mat2sheets('1pglB7Y7r7I8c5n1UI55jVoqKZtDlRZXfiAb4juHeh90', '0', [2 1], message);
    
    
elseif B == 0
user_priority = [];
added_user = user_list(Row,2);
for i = 1:Final_row
A = Final_user_list(i,1);
tf = strcmp(added_user,A);
user_priority(i) = tf;
end

k = find(user_priority);

Added_priority = Final_user_list(k,2);
Admin_priority = str2double(Added_priority);
New_user_priority = str2double(user_list(Row,3));

if Admin_priority > New_user_priority
    message = {'priority conflict found'};
    status = mat2sheets('1pglB7Y7r7I8c5n1UI55jVoqKZtDlRZXfiAb4juHeh90', '0', [2 1], message);
elseif Admin_priority <= New_user_priority
    message = {'user added successfully'};
    status = mat2sheets('1pglB7Y7r7I8c5n1UI55jVoqKZtDlRZXfiAb4juHeh90', '0', [2 1], message);
    New_add = user_list([Row],:);
    New_add(:,2) = [];
    A = cat(1, Final_user_list, New_add);
    status = mat2sheets('1pglB7Y7r7I8c5n1UI55jVoqKZtDlRZXfiAb4juHeh90', '1728085595', [1 1], A);
    
end
end

list = GetGoogleSpreadsheet('1pglB7Y7r7I8c5n1UI55jVoqKZtDlRZXfiAb4juHeh90','1728085595');


% message = {'user exist'};
% status = mat2sheets('1pglB7Y7r7I8c5n1UI55jVoqKZtDlRZXfiAb4juHeh90', '0', [2 1], message);


end