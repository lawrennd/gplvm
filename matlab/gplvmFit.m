function model = gplvmFit(Y, dims, options, kernelType, noiseType, ...
                          selectionCriterion, numActive, lbls)

% GPLVMFIT Fit a Gaussian process latent variable model.

% GPLVM

if nargin < 8
  lbls = [];
end


model = gplvmInit(Y, dims, options, kernelType, noiseType, selectionCriterion, numActive);
model = gplvmOptimise(model, options, lbls);
