function D = EuclideanD(a,b)
% a,b: two matrices; each row is a data
% d:   distance matrix of a and b
a = a'; b = b';

if (size(a,1) == 1)
    a = [a; zeros(1,size(a,2))];
    b = [b; zeros(1,size(b,2))];
end

aa=sum(a.*a); bb=sum(b.*b); ab=a'*b;
D = repmat(aa',[1 size(bb,2)]) + repmat(bb,[size(aa,2) 1]) - 2*ab;

D = real(D);
D = sqrt(D);
D = max(D,0);
D = D.*(1-eye(size(D))); % force 0 on the diagonal

