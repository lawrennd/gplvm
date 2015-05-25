clear all
close all
colordef white
importTool('ndlutil', 0.131)
importTool('kern', 0.131)
importTool('noise', 0.121)
importTool('prior', 0.12)
importTool('optimi', 0.12)
importTool('ivm', 0.31)
importTool('mocap')
importTool('gplvm', 2.012)
disp('Press R key for Swagger Visualisation.')
r = input('Type ''R'' to run or ''S'' to skip: ', 's');
switch r
  case {'r', 'R'}
   clear all
   close all
   HOME =getenv('HOME');
   mocapResultsCppBvh('swagger.model', [HOME '\datasets\mocap\Swagger.bvh'], 'bvh')
  otherwise
end
disp('Press R key for Swagger Back Constrained Visualisation.')
r = input('Type ''R'' to run or ''S'' to skip: ', 's');
switch r
  case {'r', 'R'}
   clear all
   pause(0.5)
   HOME =getenv('HOME');
   mocapResultsCppBvh('swagger_back_constrained.model', [HOME '\datasets\mocap\Swagger.bvh'], 'bvh')
   
 otherwise
end
