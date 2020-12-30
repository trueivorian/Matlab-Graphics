% TODO: Implement raySphereIntersect function here.
% This function sends a ray from [rayX, infinity, rayZ] and calculates if
% it intersects with a sphere that is centered at origin and that has
% radius r. 
%
% Note: You don't actually need to send a ray! Just check if the ray
% intersects with the sphere or not
%
% x : x coordinate (scalar). 
% z : z coordinate (scalar).
% radius: Radius of sphere centered at origin (scalar).
% y : y coordinate of intersection point (scalar) (the value will be used
% only if success==true)
% success: true if hit, false if no hit.
%
% (Hint: x and z are distances from the centre of the image.  For the ray
% to intersect the sphere, this point should be within the area that can be
% spanned by the radius) 

function [ y, success ] = raySphereIntersect( rayX, rayZ, r )
    y = sqrt((r^2 - rayX^2 - rayZ^2));
    success = ((r^2 - rayX^2 - rayZ^2)>=0);
end
