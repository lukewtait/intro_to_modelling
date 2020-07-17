function plotPhasePlane(model, nullcline_step, field_downsample)

    if nargin < 2
        nullcline_step=0.01;
    end
    if nargin < 3
        field_downsample = 10;
    end

    % Draw vector field
    [x1, x2] = meshgrid(0:nullcline_step:1, 0:nullcline_step:1);

    v1 = zeros(size(x1));
    v2 = zeros(size(x2));
    for i = 1:size(x1,1)
        for j = 1:size(x2,1)
            % out = eval([model '([x1(i,j);x2(i,j)])']);
            out = model([x1(i,j);x2(i,j)]) ; 
            v1(i,j) = out(1);
            v2(i,j) = out(2);
        end
    end
    hold on;
    quiver(x1(1:field_downsample:end,1:field_downsample:end),...
           x2(1:field_downsample:end,1:field_downsample:end),...
           v1(1:field_downsample:end,1:field_downsample:end),...
           v2(1:field_downsample:end,1:field_downsample:end),...
           'Color',0.6*ones(1,3))
    
    
    % Draw nullclinces
    contour(x1, x2, v1, [0, 0], 'LineColor', 'g');
    contour(x1, x2, v2, [0, 0], 'LineColor', 'm');
    hold off;