function [model, lbls] = gplvmReadFromFID(FID)

% GPLVMREADFROMFID Load from a FID produced by the C++ implementation.

% GPLVM

lineStr = getline(FID);
tokens = tokenise(lineStr, '=');
if(length(tokens)~=2 | ~strcmp(tokens{1}, 'gplvmVersion'))
  error('Incorrect file format.')
end
if(~strcmp(tokens{2}, '0.1') & ~strcmp(tokens{2}, '0.11'))
  error('Incorrect file version.')
end
version = str2num(tokens{2});

lineStr = getline(FID);
tokens = tokenise(lineStr, '=');
if(length(tokens)~=2 | ~strcmp(tokens{1}, 'numData'))
  error('Incorrect file format.')
end
numData = str2num(tokens{2});

lineStr = getline(FID);
tokens = tokenise(lineStr, '=');
if(length(tokens)~=2 | ~strcmp(tokens{1}, 'numProcesses'))
  error('Incorrect file format.')
end
dataDim = str2num(tokens{2});

lineStr = getline(FID);
tokens = tokenise(lineStr, '=');
if(length(tokens)~=2 | ~strcmp(tokens{1}, 'latentDim'))
  error('Incorrect file format.')
end
latentDim = str2num(tokens{2});

if(version>0.1)
  lineStr = getline(FID);
  tokens = tokenise(lineStr, '=');
  if(length(tokens)~=2 | ~strcmp(tokens{1}, 'dynamicsLearnt'))
    error('Incorrect file format.')
  end
  dynamicsLearnt = str2num(tokens{2});
else
  dynamicsLearnt = 0;
end
kern = kernReadFromFID(FID);
if dynamicsLearnt
  dynKern = kernReadFromFID(FID);
end
noise = noiseReadFromFID(FID);

labelsPresent = 0;
labels=ones(numData, 1);
lineStr = getline(FID);
tokens = tokenise(lineStr,',');
for i=1:length(tokens)
  subTokens = tokenise(tokens{i}, ':');
  if strcmp(subTokens{1}, 'Y')
    if str2num(subTokens{2})~=dataDim
      error('Incorrect file format.');
    end
  elseif strcmp(subTokens{1}, 'X')
    if str2num(subTokens{2})~=latentDim
      error('Incorrect file format.');
    end
  elseif strcmp(subTokens{1}, 'labels')
    labelsPresent = 1;
    if str2num(subTokens{2})~=1
      error('Incorrect file format.');
    end
  else
    error('Incorrect file format.');
  end
end

X = zeros(numData, latentDim);
y = zeros(numData, dataDim);

for i=1:numData
  lineStr = getline(FID);
  tokens = tokenise(lineStr);
  for j=1:dataDim
    y(i, j) = str2num(tokens{j});
  end
  for j=1:latentDim
    X(i, j) = str2num(tokens{j+dataDim});
  end
  if labelsPresent
    labels(i) = str2num(tokens{dataDim+latentDim+1});
  end
end
if(~strcmp(noise.type, 'scale'))
  error('Can only load noise of type scale.')
end
[ivmInfo.m, ivmInfo.beta] = scaleNoiseSites(noise, [], [], [], [], y);
ivmInfo.I = 1:size(X, 1);
ivmInfo.J=[];

model = ivmReconstruct(kern, noise, ivmInfo, X, y);
lbls=[];
if labelsPresent
  minLbl = min(labels);
  maxLbl = max(labels);
  counter = 0;
  for i=minLbl:maxLbl
    counter = counter + 1;
    lbl = zeros(size(labels));
    lbl(find(labels==i))=1;
    lbls = [lbls lbl];
  end
end