function X = gplvmPcaInit(Y, dims)

% GPLVMPCAINIT Initialise gplvm model with PCA.

% GPLVM

[v, u] = pca(Y);
v(find(v<0))=0;
Ymean = mean(Y);
Ycentre = zeros(size(Y));
for i = 1:size(Y, 2);
  Ycentre(:, i) = Y(:, i) - Ymean(i);
end
X = Ycentre*u(:, 1:dims)*diag(1./sqrt(v(1:dims)));
sigma2 = mean(v(dims+1:end));
