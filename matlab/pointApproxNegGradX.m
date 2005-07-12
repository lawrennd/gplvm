function g = pointApproxNegGradX(x, m, beta, model, prior)

% POINTAPPROXNEGGRADX Wrapper function for calling approximate noise gradients.

% GPLVM

g = ivmApproxGradX(model, x, m, beta);

% check if there is a prior over kernel parameters
if nargin > 3
  g = g + priorGradient(prior, x(prior.index));
end

g = -g;
