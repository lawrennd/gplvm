function model = gplvmInit(Y, dims, options, kernelType, noiseType, selectionCriterion, numActive)

% GPLVMINIT Initialise a GPLVM model.

% GPLVM

% Initialise X.
[X, resVariance] = gplvmInitX(Y, dims, options);

% Set up gplvm as an ivm.
model = ivm(X, Y, kernelType, noiseType, selectionCriterion, numActive);

    
  