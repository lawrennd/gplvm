colordef white
disp('Ready ... press R key for digit demo with full circle.')
disp('demManifold([2 3], ''all'')')
r = input('Type ''R'' to run or ''S'' to skip: ', 's');
switch r
  case {'r', 'R'}
   close all
   clear all
   demManifold([2 3], 'all');
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
importTool('ndlutil', 0.141);
importTool('kern');
importTool('noise', 0.13);
importTool('prior', 0.13);
importTool('optimi', 0.13);
importTool('mocap', 0.12);
importTool('fgplvm');
importTool('datasets', 0.1);
importTool('mltools', 0.1);
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
disp('Press R Key for visualisation of dynamics priors.')
r = input('Type ''R'' to run or ''S'' to skip: ', 's');
switch r
  case {'r', 'R'}
   clear all
   close all
   figure
   set(gcf, 'units', 'normalized')
   set(gcf, 'position', [0.1 0.1 0.8 0.8])
   varVal = 0.04;
   pairs(1, :) = [0.1 0.0001];
   pairs(2, :) = [0.1 0.04];
   pairs(3, :) = [1 0.0001];
   pairs(4, :) = [1 0.04];
   pairs(5, :) = [10 0.0001];
   pairs(6, :) = [10 0.04];
   map(1) = 1;
   map(2) = 4;
   map(3) = 2;
   map(4) = 5;
   map(5) = 3;
   map(6) = 6;
   for i=1:size(pairs, 1)
     kern = kernCreate(zeros(1, 2), {'rbf', 'white'});   
     kern.comp{2}.variance = pairs(i, 2)*varVal;
     kern.comp{1}.inverseWidth=pairs(i, 1);
     kern.comp{1}.variance=varVal;
     msg = ['Width ' num2str(1/pairs(i, 1)) ...
            ', SNR: ' num2str(1/(sqrt(pairs(i, 2))))];
     subplot(2, 3, map(i))
     for j = 1:5
       fgplvmKernDynamicsSample(kern, 15);
       %title(['Sample ' num2str(j) ': ' msg])
       title(msg)
       pause(0.5)
     end
     pause(0.5)
   end
 otherwise
end

disp('Press R key for Swagger Dynamics Visualisation.')
r = input('Type ''R'' to run or ''S'' to skip: ', 's');
switch r
  case {'r', 'R'}
   clear all
   close all
   HOME =getenv('HOME');
   mocapResultsCppBvh('swagger_dynamics.model', [HOME '\datasets\mocap\Swagger.bvh'], 'bvh')
  otherwise
end
