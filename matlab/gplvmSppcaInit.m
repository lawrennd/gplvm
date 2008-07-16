function [X, sigma2] = gplvmSppcaInit(Y, dims)

% GPLVMSPPCAINIT Initialise gplvm model with Scaled Probabilistic PCA.

% GPLVM

% Scale all Y values before doing probabilistic PCA.
for i = 1:size(Y, 2);
  va = var(Y(find(~isnan(Y(:, i))), i));
  if va ~= 0
    Y(:, i) = Y(:, i)/sqrt(va);
  end
end
[X, sigma2] = gplvmPpcaInit(Y, dims);
