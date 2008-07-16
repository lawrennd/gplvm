function [model,labels] = gplvmReadFromFile(fileName)

% GPLVMREADFROMFILE Load a file produced by the c++ implementation.

% GPLVM

FID = fopen(fileName);
if FID==-1
  error(['Cannot find file ' fileName])
end
[model, labels] = gplvmReadFromFID(FID);
fclose(FID);