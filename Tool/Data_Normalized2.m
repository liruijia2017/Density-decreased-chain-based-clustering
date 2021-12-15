function [a] = Data_NormalizedL2(a)
[~,n]= size(a);

a2 = a.^2;
s = sum(a2,2);
s = s.^(1/2);
s = repmat(s,1,n);
a = a./s;
a(isnan(a)==1) = 0;

