function [K, invK] = computeClusterKernel(X, theta);

% COMPUTECLUSTERKERNEL Compute the kernel matrix for data X with parameters theta.

theta = thetaConstrain(theta);
expX = exp(X);
sumExpX = sum(expX, 2);
S = zeros(size(X));
for j = 1:size(X, 2)
  S(:, j) = expX./sumExpX;
end
K = theta(1)*S*S' + eye(size(X, 1))*1/theta(end);

if nargout > 1
  invK = pdinv(K);
end
