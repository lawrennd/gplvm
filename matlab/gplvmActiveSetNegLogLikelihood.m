function e = gplvmActiveSetNegLogLikelihood(xVals, y, model, prior)

% GPLVMACTIVESETNEGLOGLIKELIHOOD Wrapper function for calling noise likelihoods.
% GPLVM

model.X(model.I, :) = reshape(xVals, length(model.I), size(model.X, 2));
L = ivmApproxLogLikelihood(model);

% check if there is a prior over kernel parameters
if nargin > 3 & ~isempty(prior)
  for i = model.I
    L = L + priorLogProb(prior, model.X(i, prior.index));
  end
end
e = -L;
