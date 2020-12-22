function A = timerange(Hr_start,Hr_end)
Time = 0:23;
Time_range_start = circshift(Time,[0 (24-Hr_start)]);
k_1 = find(ismember(Time_range_start,Hr_end));
A = Time_range_start(1:k_1);
end