function [Y, lbls] = gplvmLoadData(dataset)

% GPLVMLOADDATA Load the a dataset.

% GPLVM
lbls = [];
switch dataset
  case 'brendan'
   load frey_rawface.mat
   Y = double(ff)';
   
 case 'digits'

  % Fix seeds
  randn('seed', 1e5);
  rand('seed', 1e5);

  load usps_train.mat
  % Extract 600 of digits 0 to 4
  [ALL_T, sortIndices] = sort(ALL_T);
  ALL_DATA = ALL_DATA(sortIndices(:), :);
  Y = [];
  lbls = [];
  numEachDigit = 600;
  for digit = 0:4;
    firstDigit = min(find(ALL_T==digit));
    Y = [Y; ALL_DATA(firstDigit:firstDigit+numEachDigit-1, :)];
    lbl = zeros(1, 5);
    lbl(digit+1) = 1;
    lbls = [lbls; repmat(lbl, numEachDigit, 1)];
  end

 case 'twos'  
  % load data
  load twos
  Y = 2*a-1;

 case 'oil'
  load 3Class
  Y = DataTrn;
  lbls = DataTrnLbls;

 case 'swissRoll'
  load swiss_roll_data
  Y = X_data(:, 1:1000)';
end
