function A = Invalid_check_Admin(X,B,C,D)

User_ID = B(:,2);
unique_user = unique(User_ID);
null_Index = strcmp(unique_user(:,1),'null');
unique_user(null_Index,:)=[];
unique_user(1,:)=[];
A = {};
for i=1:size(unique_user,1)
r = find(ismember(X, unique_user(i)));
if r ~= 0
    A{i} = 'user exist';
else 
    A{i} = 'invalid user';
    
end
end
Index = find(ismember(A, 'invalid user'));
Invalid_Index = unique_user(Index,1);

for i = 1:size(Invalid_Index,1)
Invalid_user_Index = strcmp(User_ID,Invalid_Index{i});
Invalid_policy_index = C(Invalid_user_Index,:);
Invalid_Policy = Invalid_policy_index(:,1);
Policy_decision_index = find(ismember(D(:,1), Invalid_Policy));
D{Policy_decision_index,2}= 'Invalid User';
end
A=D;
end