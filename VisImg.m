function [] = VisImg(img, circles, chPointsX, chPointsY, points, col)
    centers = [];
    radiuses = [];
    
    for i = 1:length(circles)
        centers = [centers; circles(i).center];
        radiuses = [radiuses circles(i).radius];
    end
    
    imshow(img)
    hold on 
    viscircles(centers, radiuses, 'EdgeColor', col);
    plot(chPointsX, chPointsY, 'r-');
    plot(points(:, 1), points(:, 2), 'g+');
end

