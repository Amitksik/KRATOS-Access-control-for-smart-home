function [Hr_start, Hr_end, Min_start, Min_end] = time(A1,A2)


d1 = datetime(A1,'InputFormat','uuuu-MM-dd''T''HH:mm:ss.SSSXXXX','TimeZone','UTC-5');
DateString1 = datestr(d1,'HH');
Hr_start = str2double(DateString1);
Hr_start = Hr_start';
DateString2 = datestr(d1,'MM');
Min_start = str2double(DateString2);
Min_start = Min_start';
d2 = datetime(A2,'InputFormat','uuuu-MM-dd''T''HH:mm:ss.SSSXXXX','TimeZone','UTC-5');
DateString3 = datestr(d2,'HH');
Hr_end = str2double(DateString3);
Hr_end = Hr_end';
DateString4 = datestr(d1,'MM');
Min_end = str2double(DateString4);
Min_end = Min_end';



end
