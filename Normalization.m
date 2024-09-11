function [X] = Normalization(X)

X(isnan(X)) = 0;
X(isinf(X)) = 1e5;
norm_mat = repmat(sqrt(sum(X.*X,2)),1,size(X,2));
for i = 1:size(norm_mat,1)
    if (norm_mat(i,1)==0)
        norm_mat(i,:) = 1;
    end
end
X = X./norm_mat;