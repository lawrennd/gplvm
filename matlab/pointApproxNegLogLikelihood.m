function e = pointApproxNegLogLikelihood(x, m, beta, model, prior)

% POINTAPPROXNEGLOGLIKELIHOOD Wrapper function for calling likelihoods.

% GPLVM

L = ivmApproxLogLikelihood(model, x, m, beta);

% check if there is a prior over kernel parameters
if nargin > 3
  L = L + priorLogProb(prior, x(prior.index));
end
e = -L;
