function model = gplvmInit(Y, dims, options, kernelType, noiseType, selectionCriterion, numActive)

% GPLVMINIT Initialise a GPLVM model.

% GPLVM

% Initialise X.
[X, resVariance] = gplvmInitX(Y, dims, options);

% Set up gplvm as an ivm.
model = ivm(X, Y, kernelType, noiseType, selectionCriterion, numActive);

%/~ If a residual variance was provided, set white noise with it.
%if ~isempty(resVariance);
%  model.kern = kernSetWhite(model.kern, resVariance);
%end
%~/
    
  