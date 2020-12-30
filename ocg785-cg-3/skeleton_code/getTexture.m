% TODO: Implement getTexture function.
% First, perform linear mapping from spherical coordinates to image
% coordinates.  theta should (positively) correlate with the second
% dimension of textureIm, while phi should (positively) correlate with the
% first dimension of textureIm.  Make sure you get the order right, and
% verify it from the provided image.  The correlation should be linear,
% which means e.g. theta and y values of textureVal should increase
% proportionally.  Then, return the pixel values (RGB) at that pixel.
%
% textureIm (W x H x 3): texture image.
% theta: azimuth (Should be in the range of [-pi, pi]).
% phi: elevation (Should be in  the range of [-pi/2, pi/2]).
% 
% textureVal: R-G-B values of the texture at desired point. 1x1x3 (double)
% The values in textureVal should be in teh range of [0, 1].
function textureVal = getTexture(textureIm, theta, phi)
    % Linear conversion.
    % Define ratio1 and ratio2 as described above.  These ratios have to be
    % in the range of [0, 1]
    
    ratio1 = (phi/pi)+(1/2);
    ratio2 = (theta/pi+1)*(1/2);
    
    pixel1 = round(ratio1*size(textureIm,1)); % the row coordinate
    if pixel1 < 1
        pixel1 = 1;
    end
    
    pixel2 = round(ratio2*size(textureIm,2)); % the col coordinate
    if pixel2 < 1
        pixel2 = 1;
    end
    
    
    % return the textureVal at that pixel in the textureIm. This values
    % should be within [0 1]
    colour  = textureIm(pixel1,pixel2,:);
    colourD = double(colour);
    textureVal = colourD/256;
end