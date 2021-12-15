function [a] = Data_Normalized(a,b1,b2)
[m,n]= size(a);

for i = 1: n
    amax = max(a(:,i));  
    amin = min(a(:,i));  
    for j = 1: m
       a(j,i)= (a(j,i)-amin)/(amax-amin)*(b2-b1)+b1;  
    end
end
a(isnan(a)==1) = 0;

