function e = pointNegLogLikelihood(x, y, model, prior)

% POINTNEGLOGLIKELIHOOD Wrapper function for calling likelihoods.

% GPLVM

e = - ivmLogLikelihood(model, x, y);

if prior
  e =e +0.5*x*x';
end