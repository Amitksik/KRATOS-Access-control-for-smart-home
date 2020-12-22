function [priority1,priority2] = prioritycheck(A,B)

User_index =  strcmp(A(1,:),'User Email');
Admin_index = strcmp(A(1,:),'Admin Email');
User_email_list = A(:,User_index);
Admin_email_list = A(:,Admin_index);
User_email_list(1,:) = [];
Admin_email_list(1,:) = [];
priority1 = {};
priority2 = {};
for i=1:size(User_email_list,1)
 A = User_email_list(i,1);
 user = strcmp(B(:,1),A);
 C= B(user,:);
 priority1(i) = C(2);
    
end

for i=1:size(Admin_email_list,1)
 A = Admin_email_list(i,1);
 user = strcmp(B(:,1),A);
 C= B(user,:);
 priority2(i) = C(2);
    
end

end