function A = update_decision(B,C)

Conflict_Index = strcmp(B(:,2),'null');
A = C(Conflict_Index,:);

end