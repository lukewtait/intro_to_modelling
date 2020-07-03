function plotPhasePlane(model, limit, step)

  if nargin < 2
    limit = 3;
  end
  if nargin < 3
   step = 0.1;
  end

  [x1, x2] = meshgrid(-limit:step:limit, -limit:step:limit);

  v1 = zeros(size(x1));
  v2 = zeros(size(x2));
  for i = 1:size(x1,1)
    for j = 1:size(x2,1)
      out = eval([model '([x1(i,j);x2(i,j)])']);
      v1(i,j) = out(1);
      v2(i,j) = out(2);
    end
  end
  hold on;
  quiver(x1, x2, v1, v2)
  contour(x1, x2, v1, [0, 0], 'LineColor', 'red');
  contour(x1, x2, v2, [0, 0], 'LineColor', 'blue');
  hold off;