% The function for checking how many times the given ray intersects
% the scene.
% o: origin of ray.
% d: direction vector of ray.
% V: object vertices.
% F: object faces.

% numIntersects: Number of intersections
% t: distance of each intersection from origin of ray.
% fids: Face ids of intersecting triangles.
% Written by Vladislav Kramarev

function [numIntersects, t, fids] = raySceneIntersect(o, d, V, F)
    
    is_visualize = false;
    if size(V, 2) ~= 3
        V = V';
    end
    if size(F, 2) ~= 3
        F = F';
    end
    lenF = size(F, 1);
    is = []; 
    t = [];
    numIntersects = 0;

    [t, fids] = rayTriangleIntersect(o, d, V(F(:, 1), :), V(F(:, 2), :), V(F(:, 3), :));
    numIntersects = length(t); % number of intersection of the ray with the mesh
    
    if numIntersects > 0
        a = 2;
    end
    
    if is_visualize %&& mod(numIntersects, 2) == 1  % visualize wrong normals
        figure
        VisualizeTriangulation(F, V);
        hold on
        quiver3(o(1), o(2), o(3), d(1), d(2), d(3));
        hold on
        points = zeros(numIntersects, 3);
        for i = 1: numIntersects
            points(i, :) = o + d * t(i);
        end
        scatter3(points(:, 1), points(:,2), points(:, 3));
        a = 2;
    end
end


%     for i = ids(1)%1:lenF
% 
%          [flag, ~,~,tcur] = rayTriangleIntersection (o, d, V(F(i, 1), :), V(F(i, 2), :), V(F(i, 3), :));
%         if flag
%             numIntersects = numIntersects + 1;
%             t(numIntersects) = tcur;
%             is(numIntersects) = i;
%         end
%     end
