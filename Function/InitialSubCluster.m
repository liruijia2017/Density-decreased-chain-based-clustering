function [PartLabel,subClusterID] = InitialSubCluster(W,LDCD,DDC,LDC,BP,CP)
%% Input
% W: weighted adjacency matrix of the graph
% LDCD: matrix for data points and the corresponding local density centers
% DDC: matrix for density decreased chain 
% LDC: local density centers
% BP: border points  
% CP: core points
%% Output
% PartLabel: label for initial subclusters  
% subClusterID: index for initial subclusters  

NewW = W; L = length(LDC); n = size(W,1); E = 10000000;
%% The core points connecting the border points (UnstableCorePoint)
NewW(:,BP) = 0;
NewW(BP,:) = 0;
TempW = W - NewW;
C = max(TempW);
C = find(C==0);
UnstableCorePoint = setdiff(CP,C);

%% The threshold for the intracluster density decreased chain
N = length(UnstableCorePoint); Threshold = ones(1,n) * E;
for i = 1:N
    Xi = UnstableCorePoint(1,i);
    Cut_ID = TempW(Xi,:);
    Threshold(1,Xi) = min(nonzeros(Cut_ID));
end
ThresholdMat = repmat(Threshold,[n,1]);
ThresholdMat = max(ThresholdMat,ThresholdMat');

One = sum(LDCD(CP,:),2);
Only = CP(One == 1);
ThresholdMat(Only,Only) = E;
DDCandW  = (1-DDC)*E + W;


%% Initial subclusters with respect to the LDCs.
DDC(:,BP) = 0; DDC(BP,:) = 0;
ISC = cell(1,L); 
for i = 1:L
    ISC{1,i} = LDC(i);
    NewPoint = LDC(i); 
    while ~isempty(NewPoint)      
        LatentSubG = DDC(NewPoint,:);
        TempSubCluster = find(max(LatentSubG,[],1) == 1);
        ThresholdNewPoint = ThresholdMat(NewPoint,TempSubCluster);
        WeightNewPoint = DDCandW(NewPoint,TempSubCluster);
        Condition =  double(WeightNewPoint < ThresholdNewPoint);
        ID = max(Condition,[],1) == 1;
        NewPointTemp = TempSubCluster(ID);    
        NewPoint = setdiff(NewPointTemp,ISC{1,i});
        ISC{1,i} = [ISC{1,i},NewPoint];
    end  
end

%%  Merging the subclusters whose intersection is not empty
MatC = zeros(L);
for i = 1:L
    for j = i+1:L
        L0 = length(unique([ISC{1,i},ISC{1,j}]));
        L1 = length(ISC{1,i});
        L2 = length(ISC{1,j});
        L3 = L0 - L1 - L2;
        if L3
           MatC(i,j) = 1; 
        end
    end
end
MatC = max(MatC,MatC');   
[Component,~] = Net_Branches(MatC);

m = size(Component,1); 
PartLabel = zeros(n,1); 
subClusterID = zeros(1,L);
for i = 1:m
    TempC = nonzeros(Component(i,:));
    Len = length(TempC);
    for j = 1:Len
        subCluster = ISC{1,TempC(j,1)};
        PartLabel(subCluster,1) = i;
    end
    subClusterID(TempC) = i;
end




