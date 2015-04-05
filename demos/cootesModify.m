function cootesModify(handle, values, connect, bb)

% COOTESMODIFY Helper code for visualisation of a 2d face.



vals = reshape(values, size(values, 2)/2, 2);

indices = find(connect);
[I, J] = ind2sub(size(connect), indices);
set(handle(1), 'Xdata', vals(:, 1), 'Ydata', vals(:, 2));
set(get(handle(1), 'parent'), 'xlim', bb(1, :));
set(get(handle(1), 'parent'), 'ylim', bb(2, :));
%set(handle(1), 'visible', 'on')


for i = 1:length(indices)
  set(handle(i+1), 'Xdata', [vals(I(i), 1) vals(J(i), 1)], ...
            'Ydata', [vals(I(i), 2) vals(J(i), 2)]);
end
