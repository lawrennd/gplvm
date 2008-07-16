function X = gplvmKpcaInit(Y, kern, dims)

% GPLVMKPCAINIT Initialise gplvm model with Kernel PCA.

% GPLVM

X = kpcaEmbed(Y, dims, kern);
