function run_code
    %% Running this code after all the other codes are completed correctly will save 3 images in the 'output' folder.
    % Submit the codes as well as the output folder.  Note that this file
    % should not be changed.  Modifications should be made only to the
    % accompanying codes as specified in the assigment.
    
    %%%%%% Parameters of main primitive %%%%%%

    radius = 150;
    objectRadius = 100;

    % Turn this flag on to visualize the images.
    visualizationFlag = true;

    % Create output folder.
    if ~exist('./output','dir')
        mkdir('./output');
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    viewerDistance = 300;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %Size of the output image - 300x300 is the spatial resolution of the
    %image and 3 is the number of channels (R,G,B)
    Im = zeros(300,300,3);  % output image

    %% Initializing data structures.
    % The texture to be used.
    textureIm = imread('world.png');

    % Create texture pyramid.
    texturePyramid = cell(4, 1);
    texturePyramid{1} = textureIm;      % highest resolution
    texturePyramid{2} = imresize(textureIm,0.5);
    texturePyramid{3} = imresize(textureIm,0.25);
    texturePyramid{4} = imresize(textureIm,0.125);  %lowest resolution

    % Create sphere for inverse texture mapping
    [x,y,z] = sphere(6); % Increasing 6 to higher values will result in better visual result, but will be computationally slower (DO NOT CHANGE)    
    
    % 'surf2patch' converts the geometry and color data from SURFACE object
    % S into PATCH format.  The struct 'fvc' contains the faces, vertices
    % and colors of the patch data. 
    fvc = surf2patch(x,y,z,'triangles'); % creates triangular faces instead of quadrilaterals. 
    V = (fvc.vertices)' * objectRadius;  % scaling to the radius of the sphere   
    F = (fvc.faces)';

    %% VISUALIZATION OF THE TEXTURE.
    %----------------------------------------------------------
    for x = -149:150
        for z = -149:150
            % Note that since x and z are taken from the -149:150, when
            % x=0, z=0, it corresponds to the centre of the image (of size 300x300).
            %% Find intersection with the vertices.
            % TODO: Fill this function.
            [y, success] = raySphereIntersect(x, z, radius);

            if ~success
                continue;
            end

            %% Convert to spherical coordinates.
            P = [x y z];
            % TODO: Fill this function.
            [theta, phi, ~] = cart2sph(P(1),P(2),P(3));

            %% Map from spherical coords to pixels.
            % TODO: Fill this function.
            textureVal = getTexture(textureIm, theta, phi);

            %% add to the output image.
            Im(x + 150,z + 150,:) = textureVal;
        end
    end
    % Display and save the image
    if visualizationFlag
        figure, imshow(imrotate(Im,-90));
    end
    imwrite(imrotate(Im,-90), [pwd '/output/texture.png']);
    

    %% Perform anti-aliasing here.
    Im = zeros(300,300,3);  % reset the output image
    for x = -149:150
        for z = -149:150
            %% Find intersection with the vertices.
            [y, success] = raySphereIntersect(x, z, radius);

            if ~success
                continue;
            end

            %% Convert to spherical coordinates.
            P = [x y z];
            [theta, phi, ~] = cart2sph(P(1),P(2),P(3));

            %% Perform Anti-aliasing using MIP mapping
            % TODO: You need to change textureIm with the relevant texture
            % map from texturePyramid, as explained in the assignment text.
            tempIm = getTextureMap(P, texturePyramid);
            
            %% Map from spherical coords to pixels.
            textureVal = getTexture(tempIm, theta, phi);

            %% add to the output image.
            Im(x + 150,z + 150,:) = textureVal;
        end
    end
    
    % Display and save the image
    imwrite(imrotate(Im,-90), [pwd '/output/antialiasing.png']);
    if visualizationFlag
        figure, imshow(imrotate(Im,-90));
    end

    
    
    %% Implement inverse texture mapping.
    Im = zeros(300,300,3);  % reset the output image
    for x = -149:150
        for z = -149:150
            %% First of all, we check if the rays intersect with any of the faces of the inner sphere.
            [num, t, ~] = raySceneIntersect([x, viewerDistance, z], [0, -1, 0], V, F);

            if num == 0
                continue;
            end

            %% Find closest triangle and its distance to the viewer.
            [tMin, ~] = min(t);

            %% Find the point of intersection on the object and outer sphere.
            % TODO: Fill this function.
            [spherePoint] = findPoint(x, z, tMin, viewerDistance, radius);

            %% Convert to spherical coordinates.
            [theta, phi, ~] = cart2sph(spherePoint(1),spherePoint(2),spherePoint(3));

            %% Map from spherical coords to pixels.
            textureVal = getTexture(textureIm, theta, phi);

            %% add to the output image.
            Im(x + 150, z + 150,:) = textureVal;
        end
    end

    % Display and save the image
    imwrite(imrotate(Im,-90), [pwd '/output/inverse_map.png']);
    if visualizationFlag
        figure, imshow(imrotate(Im,-90));
    end
end