function K1 = kernelClusterDiffParams(arg1, arg2, arg3);

% KERNELCLUSTERDIFFPARAMS Get gradients of kernel wrt its parameters.

if nargin < 3
  X1 = arg1;
  X2 = arg1;
  theta = arg2;
else
  X1 = arg1;
  X2 = arg2;
  theta = arg3;
end

theta = thetaConstrain(theta);

expX1 = exp(X1);
sumExpX1 = sum(expX1, 2);
S1 = zeros(size(X1));
for j = 1:size(X1, 2)
  S1(:, j) = expX1./sumExpX1;
end

expX2 = exp(X2);
sumExpX2 = sum(expX2, 2);
S2 = zeros(size(X2));
for j = 1:size(X2, 2)
  S2(:, j) = expX2./sumExpX1;
end


K1 = S1*S2';
