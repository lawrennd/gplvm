colordef white
disp('Ready ... press R key for digit demo with full circle.')
disp('demManifold([2 3], ''all'')')
r = input('Type ''R'' to run or ''S'' to skip: ', 's');
switch r
  case {'r', 'R'}
   close all
   clear all
   demManifold([2 3], 'all')
 otherwise
end
disp('Press R key for digit demo with six separate from nine.')
disp('demManifold([2 3], ''sixnine'')')
r = input('Type ''R'' to run or ''S'' to skip: ', 's');
switch r
  case {'r', 'R'}
   close all
   clear all
   demManifold([2 3], 'sixnine')
 otherwise
end

clear all
close all
colordef white
importTool('ndlutil', 0.14)
importTool('kern')
importTool('noise', 0.13)
importTool('prior', 0.13)
importTool('optimi', 0.13)
importTool('mocap')
importTool('fgplvm')
importTool('datasets')
importTool('mltools')
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
