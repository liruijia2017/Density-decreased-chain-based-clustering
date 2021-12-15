function [WMkNN,Distance] = MutualkNNGraph(X,k)
%% Input
% X: data matrix (numSamp x dimSamp, dimSamp is the dimension)
% k: k nearest neighbors;
%% Output
% WMkNN: weighted adjacency matrix of the mutual k-NN graph
% Distance: Euclidean distance matrix of X

n = size(X,1);
Distance = EuclideanD(X,X); 
[~,Dis_ID] = sort(Distance,2); 

WDkNN = zeros(n);
for i = 1:n
    id = Dis_ID(i,2:k+1);
    WDkNN(i,id) = Distance(i,id);
end
WMkNN = min(WDkNN,WDkNN');
