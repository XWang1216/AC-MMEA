function [slst] = Clustering(X, n, bound, dim)
[a,b] = size(X);
p = X;
p(:,dim+1) = [1:a];
for i = 1 : a
   G{i} = i; 
end
M = [];
for j = 1: a
    M(j,:) = ((sum((repmat(X(j,:),size(X,1),1) - X).^2,2)).^0.5)';%M(i, j) reprents the distance of i-th cluster to the j-th cluster
end
found = 1;
while found == 1
%     [found, r, s] = FindNearestPair(G, bound, dim, n, M);
found = 0;
min_dist = (dim*((bound(2) - bound(1)).^2)).^0.5;
for i = 1:size(G,2)-1 
    for j = i + 1 :size(G,2)
        if size(G{i},2) + size(G{j},2) < n+1
            if min_dist >= M(i, j)
                min_dist = M(i, j);
                r = i;
                s = j;
                found = 1;
            end
        end
    end

end
    if ~isempty(r) && ~isempty(s)
    G{r} = [G{r}, G{s}]; % merge clusters r and s;
    for k = 1:size(G{s},2)
         p(find(p(:,dim+1)==G{s}(k)),:)=[];
    end
    G(s) = []; % delete cluster s;    
    M(:,s) = []; % update the M
    M(s,:) = []; % update the M
    h = p(:,1:dim);
    for k = 1:size(G{r},2)
        D(k,:) = ((sum((repmat(X(G{r}(k),:),size(h,1),1) - h).^2,2)).^0.5)';
    end
    D = min(D,[],1);
    M(:,r) = D';M(r,:) = D;
    D = [];
    s = [];
    r = [];
    c = 0;
    for i = 1:size(G,2)
       if size(G{i},2) == 1
           c = c + 1;
       end
    end
    if c == 0
        found = 0;
    end
    end
end 
slst = G;
end
