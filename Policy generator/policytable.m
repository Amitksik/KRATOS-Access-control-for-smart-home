function [A, B] = policytable(C,D)

removeIndex = strcmp(C(1,:),'User Email');
userlist = C(:,removeIndex);
nullindex = strcmp(userlist(:,1),'null');
A = C(nullindex,:);
A = cat(1, D, A);
B = C(~nullindex,:);

end