function model = gplvmFit(X, Y, numActive, options, noiseType, kernelType, lbls)

% GPLVMFIT Fit a Gaussian process latent variable model.

% GPLVM

if nargin < 7
  lbls = [];
end
selectionCriterion = 'entropy';

model = gplvmInit(X, Y, kernelType, noiseType, selectionCriterion, numActive);
model = gplvmOptimise(model, options, lbls);
