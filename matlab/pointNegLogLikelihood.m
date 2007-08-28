function e = pointNegLogLikelihood(x, y, model, prior)

% POINTNEGLOGLIKELIHOOD Wrapper function for calling noise likelihoods.

% GPLVM

L = ivmLogLikelihood(model, x, y);

% check if there is a prior over latent space 
if nargin > 3
  L = L + priorLogProb(prior, x);
end
e = -L;
