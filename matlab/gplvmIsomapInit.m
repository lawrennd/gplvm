function [X, sigma2] = gplvmIsomapInit(Y, dims)

% GPLVMISOMAPINIT Initialise gplvm model with isomap (need isomap toolbox).

% GPLVM

[X, sigma2] = isomapEmbed(Y, dims);