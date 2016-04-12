function [pixels, pixelLabels] = weakTimberTrainingSetConfig(imgs, labels)
    for i = 1:length(imgs)
        leftBorderX = floor(size(imgs{i}, 1) * (2 - sqrt(2)) / 4);
        rightBorderX = floor(size(imgs{i}, 1) - size(imgs{i}, 1) ...
                       * (2 - sqrt(2)) / 4);
        leftBorderY = floor(size(imgs{i}, 2) * (2 - sqrt(2)) / 4);
        rightBorderY = floor(size(imgs{i}, 2) - size(imgs{i}, 1) ...
                       * (2 - sqrt(2)) / 4);

        imgs{i} = imgs{i}(leftBorderX:rightBorderX, ...
                          leftBorderY:rightBorderY, :);
    end
    
    pixels = [];
    pixelLabels = [];
    for i = 1:length(imgs)
        colorTransform = makecform('srgb2lab');
        imgLab = applycform(imgs{i}, colorTransform);
        reshpedImg = reshape(imgLab, [], 3);
        pixelLabels = [pixelLabels; repmat(labels(i), ...
                                           size(reshpedImg, 1), 1)];
        pixels = [pixels; reshpedImg];
    end
    pixels(:, 3) = [];
    pixels = double(pixels);
end

