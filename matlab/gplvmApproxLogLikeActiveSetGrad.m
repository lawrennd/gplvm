function g = gplvmApproxLogLikeActiveSetGrad(model)

% GPLVMAPPROXLOGLIKEACTIVESETGRAD Gradient of the approximate likelihood wrt kernel parameters.

% GPLVM

x = model.X(model.I, :);
m = model.m(model.I, :);
K = kernCompute(model.kern, x);
g = zeros(1, length(model.I)*size(model.X, 2));

if model.noise.spherical
  % there is only one value for all beta
  invK = pdinv(K+diag(1./model.beta(model.I, 1)));
end

for j = 1:size(m, 2)
  if ~model.noise.spherical
    invK = pdinv(K+diag(1./model.beta(model.I, j)));
  end
  covGrad = feval([model.type 'CovarianceGradient'], invK, m(:, j));
  g = g + activeSetGradient(model, covGrad);
end  
