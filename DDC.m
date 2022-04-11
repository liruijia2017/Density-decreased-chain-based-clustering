function Label = DDC(X,k,lambda,c)
% Written by Ruijia Li (ruijia2017@163.com), UESTC, January 1, 2022.

%% Input
% X: data matrix (numSamp x dimSamp, dimSamp is the dimension)
% k: used to build the mutual k-NN graph
% lambda: used to identify core points
% c: number of the clusters 
%% Output
% Label: clustering result

%% Built the mutual k-NN graph
[W,Distance] = MutualkNNGraph(X,k); 

%% Calculate the density of the data & identify the local density center
[D,LDC] = Density(W); 

%% Built the density decreased chain
[DDC,DPS,LDCD] = DensityDecreasedChain(W,D,LDC); 

%% Identify core points
[BP,CP] = IdentifyCorePoint(DPS,LDC,D,lambda);  

%% Mine subclusters in the core points
[PartLabel,subClusterID] = InitialSubCluster(W,LDCD,DDC,LDC,BP,CP); 

%% Expand the subclusters into clusters
Label = FinalCluster(Distance,DDC,PartLabel,LDCD,subClusterID,LDC,c);


