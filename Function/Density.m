function [D,LDC] = Density(W)
%% Input
% W: weighted adjacency matrix of the graph
%% Output
% D: density of the data. 
% LDC: local density centers

n = size(W,1); e = 0.000001; 
%% Density
NonWID = (W ~= 0);
numLink = sum(NonWID,2);
weightLink = sum(W,2); 
TempD = numLink ./ (weightLink+e);
D = numLink .* TempD;

%% Local density center
matD = repmat(D',[n,1]);
matDNowW = matD .* NonWID;
MaxD = max(matDNowW,[],2);
LDC = find(D >= MaxD);







