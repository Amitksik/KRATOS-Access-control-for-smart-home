function A = usertable(B)

Header_row = B(1,:);
New_User_Email_Index = strcmp(Header_row(1,:),'User Email');
Admin_Email_Index = strcmp(Header_row(1,:),'Admin Email');
Priority_Index = strcmp(Header_row(1,:),'Priority');
New_User_Email = B(:,New_User_Email_Index);
Admin_Email = B(:,Admin_Email_Index);
Priority = B(:,Priority_Index);

A = cat(2, New_User_Email, Admin_Email, Priority);



end