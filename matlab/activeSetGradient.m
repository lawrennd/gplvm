function g = activeSetGradient(model, covGrad)

% ACTIVESETGRADIENT Gradient of the kernel with respect to its active points.

% GPLVM

xDim = size(model.X, 2);
g = zeros(length(model.I), xDim);
for i = 1:length(model.I)
  n = model.I(i);
  gx = kernGradX(model.kern, model.X(n, :), model.X(model.I, :));
  % The two accounts for the fact that covGrad is symmetric.
  gx = gx*2;
  % gx has assumed that n is not in model.I, fix that here.
  gx(i, :) = kernDiagGradX(model.kern, model.X(n, :));
  for j = 1:xDim
    g(i, j) = gx(:, j)'*covGrad(:, i);
  end
end
g = g(:)';