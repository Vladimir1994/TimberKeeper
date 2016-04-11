function pixels = takePixelsFromInscribeSquare(imgs)
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
    for i = 1:length(imgs)
        pixels = [pixels reshape(imgs{i}, [], 3)];
    end
end

