function X = gplvmPcaInit(Y, dims)

% GPLVMPCAINIT Initialise gplvm model with PCA.

% GPLVM

[X, sigma2] = ppcaEmbed(Y, dims);