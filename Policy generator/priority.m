function A = priority(B,C)

A = {};
A{1} = 'decision';
for i = 1:size(C,2)
    if str2double(C(i)) > str2double(B(i))
        A{i+1} = 'conflict found';
    elseif str2double(C(i)) <= str2double(B(i))
        A{i+1} = 'no conflict found';
    end
    
end

A = A';
end