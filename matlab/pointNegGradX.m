function g = pointNegGradX(x, y, model, prior)

% POINTNEGGRADX Wrapper function for calling noise gradients.

% GPLVM

g = ivmGradX(model, x, y);
% check if there is a prior over kernel parameters
if nargin > 3 & ~isempty(prior)
  g = g + priorGradient(prior, x);
end

g = -g;
