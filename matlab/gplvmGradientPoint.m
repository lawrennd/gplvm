function g = gplvmGradientPoint(x_i, i, model, A) %A, invK, activeX, Y, D, theta, activeSet)

% GPLVMGRADIENTPOINT Compute gradient of data-point likelihood wrt x.

% GPLVM

g = -feval([model.noiseType 'GradientPoint'], x_i, i, model, A);

