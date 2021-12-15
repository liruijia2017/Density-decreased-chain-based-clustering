function [DDC,DPS,LDCD] = DensityDecreasedChain(W,D,LDC)
%% Input
% W: weighted adjacency matrix of the graph
% D: density of the data
% LDC: local density centers
%% Output
% DDC: matrix for density decreased chain 
% DPS: data points on the density decreased chains starting with the same local density center
% LDCD: matrix for data points and the corresponding local density centers

n = size(W,1); m = length(LDC);
%% Density decreased chain
matD1 = repmat(D',[n,1]);
matD2 = matD1';
DDC = matD1 < matD2;
DDC = DDC .* double(W ~= 0);

%% Data points on the same density decreased chain (DPS) 
% The LDC with respect to each data point (LDCD) 
DPS = cell(1,m); LDCD = zeros(n,m);
for i = 1:m
    DPS{1,i} = LDC(i);
    NewPoint = DPS{1,i};
    while ~isempty(NewPoint) 
        LatentSubG = DDC(NewPoint,:);
        TempSubCluster = find(max(LatentSubG,[],1) == 1);
        NewPoint = setdiff(TempSubCluster,DPS{1,i});
        DPS{1,i} = [DPS{1,i},NewPoint];
    end  
   LDCD(DPS{1,i},i) = 1;
end

  
