function g = gplvmKernelGradient(params, model, prior)

% GPLVMKERNELGRADIENT Gradient of likelihood approximation wrt kernel parameters.

% GPLVM

xVals = params(model.kern.nParams+1:end);
model.kern = kernExpandParam(model.kern, params(1:model.kern.nParams));
model.X(model.I, :) = reshape(xVals, length(model.I), size(model.X, 2));

gX = gplvmApproxLogLikeActiveSetGrad(model);
gKern = ivmApproxLogLikeKernGrad(model);

gKern = gKern + kernPriorGradient(model.kern);
% check if there is a prior over active set positions.
if nargin > 2 & ~isempty(prior)
  gX = gX + priorGradient(prior, xVals);
end

g = [gKern gX];
g = -g;
