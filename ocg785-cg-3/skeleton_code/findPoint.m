% TODO: Implement findPoint function.
% This function, given the parameters, calculates the point of
% interest on the outer (texture) sphere S1.  First, you need to calculate
% intersectionPoint, which is the point of intersection of the ray (coming
% from the viewing direction towards the object) and the object S2.  Then,
% you need to calculate the corresponding point on the texture sphere S1 to
% perform texture mapping.  In order to do this, assume that another ray
% originates at [0,0,0] crosses through intersectionPoint and hits the
% sphere S1 (from inside).  spherePoint contains the coordinates of this
% point.

% x: x coordinate of point on the image.
% y: z zoordinate of point on the image.
% t: Distance between the intersection point and ray's origin. The origin
% of this ray is at the camera position.  The intersection is between the
% ray and the inner sphere S2.
% viewerDistance: y coordinate of the intersetion point.
% radius: Radius of outer (texture) sphere S1.

% spherePoint: Coordinates [x,y,z] of the point of interest on the outer 
% sphere S1 corresponding to the intersection point on S2.

function [spherePoint] = findPoint(x, z, t, viewerDistance, radius)
    intersection = [x, viewerDistance - t, z];
    normal = intersection/norm(intersection);
    
    spherePoint = radius*normal;
end