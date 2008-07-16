function [X, kern, noise, ivmInfo] = gplvmDeconstruct(model, fileName)

% GPLVMDECONSTRUCT break GPLVM in pieces for saving.

% GPLVM

X = model.X;
kern = rmfield(model.kern, 'Kstore');
kern = rmfield(kern, 'diagK');
noise = model.noise;
ivmInfo.I = model.I;
ivmInfo.J = model.J;
ivmInfo.m = model.m;
ivmInfo.beta = model.beta;

