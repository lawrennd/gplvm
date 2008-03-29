function [X, var] = gplvmInitX(Y, dims, options)

% GPLVMINITX Initialise the X values.

% GPLVM

initFunc = options.initX;
initFunc(1) = upper(initFunc(1));

[X, var] = feval(['gplvm' initFunc 'Init'], Y, dims);