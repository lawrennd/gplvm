function KPart = kernelClusterDiffX(X, theta, q);

% KERNELCLUSTERDIFFX Compute the gradient of the kernel with respect to X.

% Since the result is all zeros apart from one row/column combination,
% and the result is symetric, here we return a matrix whose rows are the
% vectors which give the row/column combinations  

theta = thetaConstrain(theta);

latentDim = size(X, 2);
numData = size(X, 1);

theta = thetaConstrain(theta);
expX = exp(X);
sumExpX = sum(expX, 2);
S = zeros(size(X));
S = expX(:, q)./sumExpX;
K1 = repmat(S', numData, 1);

KPart = theta(1)*(K1+diag(S));
