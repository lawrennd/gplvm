function vector3Modify(handle, values)

% VECTOR3MODIFY Helper code for visualisation of 3-D vectorial data.

% GPLVM

set(handle, 'XData', values(1));
set(handle, 'YData', values(2));
set(handle, 'ZData', values(3));

disp(values)