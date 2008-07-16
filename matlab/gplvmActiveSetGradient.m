function g = gplvmActiveSetGradient(xVals, model, prior)

% GPLVMACTIVESETGRADIENT Wrapper function for calling gradient for active set positions.

% GPLVM

model.X(model.I, :) = reshape(xVals, length(model.I), size(model.X, 2));
g = gplvmApproxLogLikeActiveSetGrad(model);

% check if there is a prior over active set positions.
if nargin > 2 & ~isempty(prior)
  g = g + priorGradient(prior, xVals);
end

g = -g;

