function L = gplvmLikelihoodPoint(x_i, i, model, A)

% GPLVMLIKELIHOODPOINT Compute gradient of data-point likelihood wrt x.

L = -feval([model.noiseType 'LikelihoodPoint'], x_i, i, model, A);
