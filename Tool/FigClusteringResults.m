function FigClusteringResults(X,Label)
figure;
[~,m] = size(X);
if m>2; [~, X, ~] = pca(X); end

c = max(Label);
Colors = {[0,1,0],[1,0,1],[0,1,1],[1,1,0],[0,0.5,1], ... 
         [1,0.5,0.5],[0,0.5,0.5],[1,0.5,0],[0.5,0.5,1],[0.5,0,0],...
         [0.5,0.5,0],[0,0.5,0],[1,1,0.5],[0.5,0,0.5],[0,0,0.5],...
         [1,0.5,1],[1,1,0.5],[1,0,0.5],[0.5,1,1],[0.5,1,0.5]};
for i = 1:c
    if i<length(Colors)+1
        scatter(X(Label == i,1), X(Label == i,2), 8, Colors{i},'o','filled'); 
    else
        scatter(X(Label == i,1), X(Label == i,2), 8,Colors{mod(i,length(Colors))+1},'o','filled');
    end
    hold on
end

scatter(X(Label == 0,1), X(Label == 0,2), 12, [0.5,0.5,0.5],'o','filled');
hold off;
axis off;


