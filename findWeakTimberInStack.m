function points = findWeakTimberInStack(img, ...
                                        chPointsX, ...
                                        chPointsY, ...
                                        estimator, ...
                                        circles)
    colorTransform = makecform('srgb2lab');
    img = applycform(img, colorTransform);
    
    points = [];
    for y = floor(min(chPointsY)):10:floor(max(chPointsY))
        for x = floor(min(chPointsX)):10:floor(max(chPointsX))
            if inpolygon(x, y, chPointsX, chPointsY)
                pixel = img(y, x, :);
                pixel(:, 3) = [];
                if predict(estimator, double(pixel)) ...
                        && ~circlesContainPoint(x, y, circles)
                    points = [points; [x, y]];
                end
            end
        end
    end
    
    function contains = circlesContainPoint(x, y, circles)
        for i = 1:length(circles)
            if pdist([x, y; circles(i).center]) < circles(i).radius
                contains = true;
                return
            end
        end
        contains = false;
    end
end

