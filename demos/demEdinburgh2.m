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
closeTool('kern', 0.13);

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