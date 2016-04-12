function [features] = computeFeatures(img)
    addpath('sfta/');
    [height, length, z] = size(img);
    colorTransform = makecform('srgb2lab');
    imgLab = applycform(img, colorTransform);
    histA = imhist(imgLab(:, :, 2), 64);
    histB = imhist(imgLab(:, :, 3), 64);
    histA = histA' ./ (height * length);
    histB = histB' ./ (height * length);
    D = sfta(img, 4);
    features = [histA, histB, D];
end

