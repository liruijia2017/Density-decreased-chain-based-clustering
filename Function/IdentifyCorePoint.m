function [BP,CP] = IdentifyCorePoint(DPS,LDC,D,lambda)
%% Input
% DPS: data points on the density decreased chains starting with the same local density center
% LDC: local density centers
% D: density of the data
% lambda: parameter used to identify core points
%% Output
% BP: border points  
% CP: core points

m = length(DPS); 
%% Border Points and Core Points
DLDC = D(LDC);
BP = [];
for i = 1:m
    Temp = DPS{1,i};
    Temp(D(Temp) >= lambda * DLDC(i)) = [];
    BP = [BP,Temp];
end
BP = unique(BP);
CP = setdiff((1:size(D,1)),BP);

