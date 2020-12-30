% TODO: Implement getTextureMap function.
% This function determines which texture maps from the texture pyramid to
% use in order to perform texture mapping.
%
% P: [x,y,z] The closest point the ray hit the sphere.
% texturePyramid: A cell array containing the same image at 4 different 
% resolutions.
% 
% tempIm: The relevant texture map (selected according to P and the
% description given in the assignment text).
function tempIm = getTextureMap(P, texturePyramid)
    
    y = P(:,2);
    if y > 100
        tempIm = texturePyramid{1};
    elseif (100>y)&&(y>=50)
        tempIm = texturePyramid{2};
    elseif (50>y)&&(y>=20)
        tempIm = texturePyramid{3};
    else
        tempIm = texturePyramid{4};
    end
end