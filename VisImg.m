function [] = VisImg(img, circles, col)
    centers = [];
    radiuses = [];
    
    for i = 1:length(circles)
        centers = [centers; circles(i).center];
        radiuses = [radiuses circles(i).radius];
    end
    
    imshow(img)
    hold on 
    viscircles(centers, radiuses, 'EdgeColor', col);
end

