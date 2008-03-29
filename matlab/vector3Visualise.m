function handle = vector3Visualise(vals)

% VECTOR3VISUALISE  Helper code for plotting a 3-D vector during 2-D visualisation.

% GPLVM

handle = plot3(vals(:, 1), vals(:, 2), vals(:, 3), 'rx');
