function e = gplvmActiveSetObjective(xVals, model, prior)

% GPLVMACTIVESETOBJECTIVE Wrapper function for calling noise likelihoods.

% GPLVM

model.X(model.I, :) = reshape(xVals, length(model.I), size(model.X, 2));
L = ivmApproxLogLikelihood(model);

% check if there is a prior over active set positions.
if nargin > 2 & ~isempty(prior)
  L = L + priorLogProb(prior, xVals);
end
e = -L;
