function env = displayQuatCurve( r, q, axis_order )
%DISPLAYROD Displays a curve given by r with the corresponding
%           director triads for each point in r.
%INPUT      r   3xN matix, where N is the total count of points.
%               r(1,:) x-axis, r(2,:) x-axis, r(3,:) x-axis.
%           q   4xN matrix, N has to be the same as for the r matrix.
%               q(1:4,:) is the director triad in quaternion
%               representation. d1 is plotted in blue, d2 in green and d3 in red.
%           axis_order  Optional parameter, allows to change the order 
%                       how the axis are displayed.
%OUTPUT     env     Variable for the plot
%
%EXAMPLE    Different possibilities:
%               displayQuatCurve([0 0 0 1 0 0 0; 0 1 0 0.701 0.701 0 0]);
%               displayQuatCurve([0 0 0 1 0 0 0; 0 1 0 0.701 0.701 0 0], [2 3 1]);
%               displayQuatCurve([0 0 0; 0 1 0], [1 0 0 0; 0.701 0.701 0 0]);
%               displayQuatCurve([0 0 0; 0 1 0], [1 0 0 0; 0.701 0.701 0 0], [2 3 1]);

%COPYRIGHT  2011-2012
%AUTHOR     Stefan Schiessl ( stefanschiessl [ät] gmx.de )
%DATE       19.06.2012

    %% If there is only one parameter, assume it has x,y,z,q1-4
    if (nargin < 2)
        q = r(:,4:7);
        r = r(:,1:3);
    end

    %% Default axis name x=r1, y=r2, z=r3.
    axis_names = {'r1' 'r2' 'r3'};
    default_axis_order = [2 3 1];
    
    %% Do we have specific axis order?
    if (nargin < 3)
        if (size(q,2) == 4)
            % q are actually quaternions, set default axis order
            axis_order = default_axis_order;
        else 
            % Only two parameters, but the second one are not quaternions,
            % assume the second one is the axis_order.
            axis_order = q;
            q = r(:,4:7);
            r = r(:,1:3);
        end
    end
    
    %% Reorder according to the axis_order
    x = r(:, axis_order(1));
    y = r(:, axis_order(2));
    z = r(:, axis_order(3));

    r = r(:, axis_order);
    
    %% Plot the curve and name the axis
    env = plot3(x, y, z);
    xlabel(axis_names(axis_order(1)));
    ylabel(axis_names(axis_order(2)));
    zlabel(axis_names(axis_order(3)));    
    
    %% How should the axis be scaled?
    autoscaling = 1;
    % Non auto scaling behaviour: Show the smallest possible window of the
    % coordinates, plot may not be scaled correctly.
    scaleMin = min(r) .* [1 1 1];
    scaleMax = max(r) .* [1 1 1];
    
    % What is the biggest difference in the coordinates?
    range = scaleMax - scaleMin;
    maxRange = max(range);
    if (maxRange == 0)
        % If the range is zero, its only a point. Show at least something
        maxRange = 0.5;
    end
        
    % Auto scaling scales every axis to the same range, plots should be
    % scaled correctly (f.e. you can see a 90 degree angle)
    if (autoscaling == 1)
        % Every axis is enhanced to show the same range of coordinates (good 
        % to minimize scaling issues)
        missingRange = maxRange - range;
        scaleMin = scaleMin - missingRange./2;
        scaleMax = scaleMax + missingRange./2;
        range = scaleMax - scaleMin;
    end
    % It's nicer to look at with some space for the last points
    extraSpace = 0.001;
    scaleMin = scaleMin - extraSpace*range;
    scaleMax = scaleMax + extraSpace*range;
    axis([scaleMin(1), scaleMax(1),...
          scaleMin(2), scaleMax(2),...
          scaleMin(3), scaleMax(3)]);
    
    %% Display the director triad only after k% of the curve length,
    % and always the first and the last one
    k = 0.02;
    coords = r';
    difference = coords(:,2:end) - coords(:,1:end-1);
    distances = sqrt(difference(1,:).^2 + difference(2,:).^2 + difference(3,:).^2);
    jetLength = sum(distances);
    % The first triad
    lenQ = size(q,1);
    displayQuats(r,q,1,range,axis_order);
    if (lenQ > 1)
        % The last triad
        displayQuats(r,q,lenQ,range,axis_order);
        %arrow(r(1,:), r(end,:), 5);
        distSinceLastQuat = 0;
        % Possible triads inbetween
        for i=2:lenQ-1
            distSinceLastQuat = distSinceLastQuat + distances(i-1);
            if (distSinceLastQuat > jetLength*k)
                displayQuats(r,q,i,range,axis_order);
                distSinceLastQuat = 0;
            end
        end
    end
    
end

% Visualizes the quaternions with the help of the corresponding 
% rotation matrix and the arrow function.
function displayQuats(r,q,i,range,axis_order)
        qi = q(i, :);
        M = convertQtoM(qi);
        x = M(1,:);
        x = x(axis_order);
        y = M(2,:);
        y = y(axis_order);
        z = M(3,:);
        z = z(axis_order);
        dir_origin = r(i,:);
        arrow_length_scaling = 0.1;
        arrow_head_size = 5;
        arrow_length = range * arrow_length_scaling;
        arrow(dir_origin, dir_origin + (arrow_length .* x) / norm(x), arrow_head_size, 'EdgeColor','b','FaceColor','b');
        arrow(dir_origin, dir_origin + (arrow_length .* y) / norm(y), arrow_head_size, 'EdgeColor','g','FaceColor','g');
        arrow(dir_origin, dir_origin + (arrow_length .* z) / norm(z), arrow_head_size, 'EdgeColor','r','FaceColor','r');
end

function [ M ] = convertQtoM( q )
%CONVERTQTOM Converts a quaternion (q = (w, x, y, z)) to a rotation matrix.
%            d1 = M(1,:), d2 = M(2,:), d3 = M(3,:).
    M = zeros(3,3);
    q0 = q(1);
    q1 = q(2);
    q2 = q(3);
    q3 = q(4);
    M(1,1) = q1^2-q2^2-q3^2+q0^2; M(1,2) = 2*(q1*q2-q0*q3);      M(1,3) = 2*(q1*q3+q0*q2); 
    M(2,1) = 2*(q1*q2+q0*q3);     M(2,2) = -q1^2+q2^2-q3^2+q0^2; M(2,3) = 2*(q2*q3-q0*q1); 
    M(3,1) = 2*(q1*q3-q0*q2);     M(3,2) = 2*(q2*q3+q0*q1);      M(3,3) = -q1^2-q2^2+q3^2+q0^2;

end


