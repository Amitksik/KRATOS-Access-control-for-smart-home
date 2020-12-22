function decision = general_policy_check(A,B)
General_policy_index = strcmp(A(1,:),'Admin Email');
General_policy_user = A(:,General_policy_index);
General_policy_user(1,:) = [];
decision ={};
decision{1} = 'Decision';
for i=1: size(General_policy_user,1)
A = General_policy_user(i,1);
user = strcmp(B(:,1),A);
C = B(user,:);
priority = C(2);

if str2double(priority)<1
    decision{i+1} = 'no conflct';
elseif str2double(priority)~=0
    decision{i+1} = 'conflict found';
end
end

decision = decision';

end