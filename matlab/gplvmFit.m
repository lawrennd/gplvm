function model = gplvmFit(X, Y, numActive, display, pointIters, extIters, ...
                          kernIters, noiseType, kernelType)

% GPLVMFIT Fit a Gaussian process latent variable model.

% GPLVM

selectionCriterion = 'entropy';
prior = 0;

model = gplvmInit(X, Y, kernelType, noiseType, selectionCriterion, numActive);
model = gplvmOptimise(model, prior, display, pointIters, extIters, kernIters);
