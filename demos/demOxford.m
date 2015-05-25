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

importTool('ndlutil');
importTool('netlab');
importTool('kern', 0.12);
importTool('noise');
importTool('gplvm');
importTool('ivm');
importTool('optimi');

disp('Press R key for digit visualisation with GPLVM.')
disp('gplvmResultsDynamic(''digits'', 3, ''image'', [16 16], 1, 1, 1)') 
r = input('Type ''R'' to run or ''S'' to skip: ', 's');
switch r
  case {'r', 'R'}
   clear all 
   close all
   pause(0.5)
   gplvmResultsDynamic('digits', 3, 'image', [16 16], 1, 1, 1);
 otherwise
end
disp('Press R key for Brendan RBF Visualisation.')
disp('gplvmResultsDynamic(''brendan'', 1, ''image'', [20 28], 1, 0, 1);')
r = input('Type ''R'' to run or ''S'' to skip: ', 's');
switch r
  case {'r', 'R'}
   clear all
   close all
   pause(0.5)
   gplvmResultsDynamic('brendan', 1, 'image', [20 28], 1, 0, 1);
 otherwise
end
disp('Press R key for Brendan MLP Visualisation.')
disp('gplvmResultsDynamic(''brendan'', 3, ''image'', [20 28], 1, 0, 1);')
r = input('Type ''R'' to run or ''S'' to skip: ', 's');
switch r
  case {'r', 'R'}
   clear all
   close all
   pause(0.5)
   gplvmResultsDynamic('brendan', 3, 'image', [20 28], 1, 0, 1);
 otherwise
end
disp('Press any key to tidy up.')
pause
closeTool('kern', 0.12);
closeTool('noise');
closeTool('gplvm');
closeTool('ivm');
closeTool('optimi');


importTool('gplvm', 1.01);
importTool('mocap', 0.001);

disp('Press R key to play Stickman data.')
disp('mocapPlayData(''run1'')')
r = input('Type ''R'' to run or ''S'' to skip: ', 's');
switch r
  case {'r', 'R'}
   clear all
   close all
   pause(0.5)
   mocapPlayData('run1');
 otherwise
end

disp('Press R key to learn Stickman data.')
disp('demStick1')
r = input('Type ''R'' to run or ''S'' to skip: ', 's');
switch r
  case {'r', 'R'}
   clear all
   close all
   pause(0.5)
   demStick1
 otherwise
end

disp('Press R key to learn Face data.')
disp('demFace1')
r = input('Type ''R'' to run or ''S'' to skip: ', 's');
switch r
  case {'r', 'R'}
   clear all
   close all
   pause(0.5)
   demFace1
 otherwise
end
disp('Press R key to play face data.')
disp('mocapPlayFaceFile')
r = input('Type ''R'' to run or ''S'' to skip: ', 's');
switch r
  case {'r', 'R'}
   clear all
   close all
   pause(0.5)
   mocapPlayFaceFile
 otherwise
end

disp('Press R key to visualise face data.')
disp('demEa')
r = input('Type ''R'' to run or ''S'' to skip: ', 's');
switch r
  case {'r', 'R'}
   clear all
   close all
   pause(0.5)
   demEa
 otherwise
end
disp('press any key to tidy up.')
pause
closeTool('mocap', 0.001);
closeTool('gplvm', 1.01);
clear all
close all