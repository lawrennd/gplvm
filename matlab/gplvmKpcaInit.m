function X = gplvmKpcaInit(Y, kern, dims)

% GPLVMKPCAINIT Initialise gplvm model with Kernel PCA.

% GPLVM
if any(any(isnan(Y)))
  error('When missing data is present Kernel PCA cannot be used to initialise')
end

K = kernCompute(kern, Y);
[u, v] = eigs(K, dims);
X = u*sqrt(v);