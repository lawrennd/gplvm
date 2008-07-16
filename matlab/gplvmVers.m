function [vers, depend] = gplvmVers

% GPLVMVERS Brings dependent toolboxes into the path.

% GPLVM

vers = 2.02;
if nargout > 2
  depend(1).name = 'ivm';
  depend(1).vers = 0.32;
  depend(1).required = 0;
end