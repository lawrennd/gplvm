function model = gplvmInit(X, Y, kernelType, noiseType, selectionCriterion, ...
                           numActive)

% GPLVMINIT Initialise a GPLVM model.

% GPLVM


model = ivm(X, Y, kernelType, noiseType, selectionCriterion, numActive);
