function [circles, chPointsX, chPointsY] = FindTimberStackArea(circles)
    addpath('dbscan/');
    
    [idx n] = dbscanCircles(circles, 2);
    clusterSize = sum(idx == 1);
    clusterSizes = clusterSize;
    counter = 2;
    while clusterSize ~= 0
        clusterSize = sum(idx == counter);
        counter = counter + 1;
        clusterSizes = [clusterSizes, clusterSize];
    end
    [~, biggestClusterIdx] = max(clusterSizes);
    circles = circles(idx == biggestClusterIdx);
    
    pointsX = [];
    pointsY = [];
    for i = 1:numel(circles)
        for angle = 0:30:360
            pointsX = [pointsX (circles(i).center(1) ...
                       + circles(i).radius * cosd(angle))];
            pointsY = [pointsY circles(i).center(2) ...
                       + circles(i).radius * sind(angle)];
        end
    end
    ch = convhull(pointsX, pointsY);
    chPointsX = pointsX(ch);
    chPointsY = pointsY(ch);
end

