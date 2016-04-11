function [features] = computeFeatures(img)
    addpath('sfta/');
    [height, length, z] = size(img);
    colorTransform = makecform('srgb2lab');
    imgLAB = applycform(img, colorTransform);
    histA = imhist(imgLAB(:, :, 2), 64);
    histB = imhist(imgLAB(:, :, 3), 64);
    histA = histA' ./ (height * length);
    histB = histB' ./ (height * length);
    D = sfta(img, 4);
    features = [histA, histB, D];
end

