function Label = FinalCluster(Distance,DDC,PartLabel,LDCD,subClusterID,LDC,c)
%% Input
% Distance: Euclidean distance matrix of X
% DDC: matrix for density decreased chain 
% PartLabel: label for initial subclusters  
% LDCD: matrix for data points and the corresponding local density centers
% subClusterID: index for initial subclusters  
% LDC: local density centers
% c: number of the clusters 
%% Output
% PartLabel: label for initial subclusters  
% subClusterID: index for initial subclusters  

m = max(PartLabel);
%% Label the remaining points
UnLabelPoint = find(PartLabel==0);
Length = length(UnLabelPoint);
while Length
    TDDC = DDC';
    TDDC(:,UnLabelPoint) = 0;
    Len = length(UnLabelPoint);
    for i = 1:Len
        Xi = UnLabelPoint(i);
        XiChain = find(TDDC(Xi,:)==1);
        if  ~isempty(XiChain)
            XiD = Distance(Xi,XiChain);
            [~,ID] = min(XiD);
            FollowID = XiChain(ID);
            PartLabel(Xi) = PartLabel(FollowID);
        end
    end
    UnLabelPoint = find(PartLabel==0);
    Length = length(UnLabelPoint);
end

%% Specify c as the number of clusters.
numPoints = zeros(1,m);
if c < m
   for i = 1:m
    numPoints(1,i) = sum(PartLabel==i);
   end
   [~, numPointsID] = sort(numPoints,'descend');
   
   PartLabelTemp = PartLabel; LabelLDCD = LDCD; J = zeros(c,m-c);
   TempNumPoints = (c+1:m);
   for i = 1:c
       TempID = subClusterID==numPointsID(i);
       for j = 1:m-c
           jPartLabel = PartLabelTemp==numPointsID(j+c);
           jLabelLDCD = LabelLDCD(jPartLabel,:);
           jSum = sum(jLabelLDCD,1);
           J(i,j) = jSum * (TempID)';
       end
   end
   maxJ = max(max(J)); NewsubClusterID = subClusterID;
   while maxJ~=0  
       [rowM,TempColM] = find(J==maxJ);
       row = rowM(1);
       TempCol = TempColM(1);
       Col = TempNumPoints(TempCol);
       TempNumPoints(TempCol) = [];
       J(:,TempCol) = [];
       ColPartLabel = find(PartLabelTemp==numPointsID(Col));
       PartLabel(ColPartLabel) = numPointsID(row);
       ColLabelLDCD = LabelLDCD(ColPartLabel,:);
       ColSum = sum(ColLabelLDCD,1);
       M = zeros(1,length(TempNumPoints));
       for t = 1:length(TempNumPoints)
          mm = TempNumPoints(t);
          TempID = subClusterID==numPointsID(mm); 
          M(t) = ColSum * (TempID)'; 
       end 
       J(row,:) = J(row,:) + M; 
       maxJ = max(max(J)); 
       NewID = subClusterID == numPointsID(Col);
       NewsubClusterID(NewID) = numPointsID(row);
   end  
   
   if ~isempty(TempNumPoints) 
       for p = 1:length(TempNumPoints)
           pp = TempNumPoints(p);
           iPartLabel = PartLabelTemp==numPointsID(pp);
           LDC_i = subClusterID==numPointsID(pp);
           ListD = zeros(1,c);
           for g = 1:c
              LDC_j = NewsubClusterID==numPointsID(g);
              LDC_D = Distance(LDC(LDC_i),LDC(LDC_j));
              [Min_V,~] = min(min(LDC_D));
              ListD(g) = Min_V;
           end
           [~,ID] = min(ListD); 
           PartLabel(iPartLabel) = numPointsID(ID); 
       end
   end    
end 

%% Organize labels
ID = unique(nonzeros(PartLabel));
cc = min(length(ID),c);
for i = 1:cc
    PartLabel(PartLabel==ID(i)) = i;
end
Label = PartLabel;
    
