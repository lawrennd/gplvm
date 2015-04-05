function handle = cootesVisualise(vals, connect, bb)

% COOTESVISUALISE For updateing a cootes representation of 3-D data.


vals = reshape(vals, size(vals, 2)/2, 2);

indices = find(connect);
[I, J] = ind2sub(size(connect), indices);
handle(1) = plot(vals(:, 1), vals(:, 2), '.');
set(handle(1), 'markersize', 20);
axis ij
set(gca, 'xlim', bb(1, :));
set(gca, 'ylim', bb(2, :));
%set(handle(1), 'visible', 'off')
hold on
grid on
for i = 1:length(indices)
  handle(i+1) = line([vals(I(i), 1) vals(J(i), 1)], ...
              [vals(I(i), 2) vals(J(i), 2)]);
  set(handle(i+1), 'linewidth', 2);
end
axis equal
%set(gca, 'zlim', [-2 2])
%set(gca, 'ylim', [-2 2])
%set(gca, 'xlim', [-2 2])
%set(gca, 'cameraposition', [15.3758 -29.5366 9.54836])