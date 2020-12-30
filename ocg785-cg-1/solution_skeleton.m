%% The solution sketch for Assignment 1. This file has to be modified and included in the submission.
%% TIP: Maximise the figure window before saving to .png file for better visualization.

clear

%% Read .obj files for the bowl object and dice
%%% Read the given meshes using the meshread.m function provided.
object_filename = sprintf('obj_models/bowl.obj');
[obj_v, obj_f, obj_n] = meshread(object_filename);

% Reading dice mesh
[dice_v, dice_f, dice_n] = meshread('obj_models/dice.obj');

%% 1. Read and display meshes in different figures
%%% Read the given meshes using the meshread.m function provided. 
%%% Visualize the two given meshes using the Matlab trisurf function. Assign a random colour to each triangle. 
%%% Save the result of your visualization for each mesh (bowl object and dice) to "1_1.png"? and "1_2.png"? file, and include these files in your submission.

figure(1);
 clf;
 color = rand(1,size(obj_v,2)); % Generates a random colour vector
 x = obj_v(1,:);
 y = obj_v(2,:);
 z = obj_v(3,:);
 tri = delaunay (x, y, z); % Uses delaunay triangulation
 trisurf (tri, x, y, z, color); % Displays bowl mesh
 
xlabel('x')
ylabel('y')
zlabel('z')
axis equal

figure(2);
 clf;
 color = rand(1,size(dice_v,2));
 x = dice_v(1,:);
 y = dice_v(2,:);
 z = dice_v(3,:);
 tri = delaunay (x, y, z);
 trisurf (tri, x, y, z, color); % Displays die mesh
xlabel('x')
ylabel('y')
zlabel('z')
axis equal
%% 2. Apply rotation transformation to bowl object mesh model
%%% Define matrices for rotation of the bowl object around x, y and z axes by 20, 80 and 55 degrees respectively. 
%%% Apply these three transformations to the original (non-transformed) bowl object in the given order 
%%% and visualize the result using trisurf function. 
%%% Save the result of your visualization to "2.png" file and include this file in your submission.

% Rotation matrices are initialised as homogenous co-ordinates

% 20 degrees rotation about the x axis
rx20 = [
        1 0 0 0;
        0 cosd(20) -sind(20) 0;
        0 sind(20) cosd(20) 0;
        0 0 0 1;
];

% 80 degrees rotation about the y axis
ry80 = [
        cosd(80) 0 sind(80) 0;
        0 1 0 0;
        -sind(80) 0 cosd(80) 0;
        0 0 0 1;
];

% 55 degrees rotation about the z axis
rz55 = [
        cosd(55) -sind(55) 0 0;
        sind(55) cosd(55) 0 0;
        0 0 1 0;
        0 0 0 1;
];

% cart2hom converts cartesian co-ordinates to homogenous co-ordinates
rotated_object_vertices = rx20*ry80*rz55*(cart2hom(obj_v.').');

figure(3);
clf;
color = rand(1,size(rotated_object_vertices,2));
x = rotated_object_vertices(1,:);
y = rotated_object_vertices(2,:);
z = rotated_object_vertices(3,:);
tri = delaunay (x, y, z);
trisurf (tri, x, y, z, color);
xlabel('x')
ylabel('y')
zlabel('z')
axis equal

%% 3. Apply scaling transformation to bowl object mesh model
%%% Define a matrix for scaling of bowl object with scaling factor f = [3.5, 1.5, 2] in direction of x, y and
%%% z axes. Apply this matrix to your original bowl object (non-transformed) and visualize the result
%%% using trisurf function. Save the result of your visualization to "3.png"? file and include this file in your
%%% submission.

% Scaling matrices are initialised as homogenous co-ordinates
s = [
     3.5 0 0 0;
     0 1.5 0 0;
     0 0 2 0;
     0 0 0 1;
];

scaled_object_vertices = s*(cart2hom(obj_v.').');

figure(4);
 clf;
 color = rand(1,size(scaled_object_vertices,2));
 x = scaled_object_vertices(1,:);
 y = scaled_object_vertices(2,:);
 z = scaled_object_vertices(3,:);
 tri = delaunay (x, y, z);
 trisurf (tri, x, y, z, color);
xlabel('x')
ylabel('y')
zlabel('z')
axis equal

%% 4. Apply translation transformation to bowl object mesh model
%%% Define a matrix for translation of bowl object by [-500, 50, -100] in direction of x, y and z axes. Apply
%%% this matrix to your original bowl object and visualize the result using trisurf function. Save the result
%%% of your visualization to "4.png"? file and include this file in your submission.

t = [
     1 0 0 -500;
     0 1 0 50;
     0 0 1 -100;
     0 0 0 1;
];
translated_object_vertices = t*(cart2hom(obj_v.').');

figure(5);
clf;
color = rand(1,size(translated_object_vertices,2));
x = translated_object_vertices(1,:);
y = translated_object_vertices(2,:);
z = translated_object_vertices(3,:);
tri = delaunay (x, y, z);
trisurf (tri, x, y, z, color);
xlabel('x')
ylabel('y')
zlabel('z')
axis equal

%% 5. Apply all 3 transformations defined above to your original (non-transformed) bowl object one after the other in the given order.
%%% Display transformed meshes in the figure using trisurf.
%%% Save the result of your visualisation to "5.png" file and include this file to you submission folder. 

%% Compute transformations (4x4 transformation matrices)

object_transformation = rx20*ry80*rz55*s*t; % You will need to compose all previous 4 transformations in homogenous form to find the final transformation of the bowl object

%% Apply object_transformation to all bowl object vertices of bowl

transformed_object_v = object_transformation*(cart2hom(obj_v.').');

figure(6);
clf;
color = rand(1,size(transformed_object_v,2));
x = transformed_object_v(1,:);
y = transformed_object_v(2,:);
z = transformed_object_v(3,:);
tri = delaunay (x, y, z);
trisurf (tri, x, y, z, color);
xlabel('x')
ylabel('y')
zlabel('z')
axis equal


%% 6. Find an appropriate rotation to be applied to the dice mesh so that its top face presents the number 3.
%%% Display both transformed meshes in the same figure using trisurf.
%%% Save the result of your visualisation to "5.png" file and include this file to you submission folder. 
%%% Hint: note that you will need to rotate the dice around an
%%%       appropriate axis (x, y or z) by multiples of 90 degrees.


dice_transformation = [
                        cosd(-90) 0 sind(-90) 0;
                        0 1 0 0;
                        -sind(-90) 0 cosd(-90) 0;
                        0 0 0 1;
]; % You will need to find an appropriate rotation represented in homogenous form to bring the dice to the approriate face number



%% Apply dice_transformation transformation to all vertices of the dice

transformed_dice_v = dice_transformation*(cart2hom(dice_v.').');


figure(7);
 clf;
 color = rand(1,size(transformed_dice_v,2));
 x = transformed_dice_v(1,:);
 y = transformed_dice_v(2,:);
 z = transformed_dice_v(3,:);
 tri = delaunay (x, y, z);
 trisurf (tri, x, y, z, color);

xlabel('x')
ylabel('y')
zlabel('z')
axis equal

%% Submission:
%%% Make required changes to this solution_skeleton.m file and submit it in a zip file along with
%%% the pdf report and the saved figures: "1_1.png", "1_2.png", "2.png", "3.png", "4.png", "5.png" and "6.png", via canvas.