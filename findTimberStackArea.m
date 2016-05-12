function circles = findTimberStackArea(circles)
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
end

