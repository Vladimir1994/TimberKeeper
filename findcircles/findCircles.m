function [centers, radiuses, metric] = findCircles(img, ...
                                                   radiusRange, ...
                                                   edgeThresh, ...
                                                   objectPolarity, ...
                                                   sensitivity)

    centers = [];
    radiuses = [];
    metric = [];

    %% Compute the accumulator array
    accumArray = computeAccumArray(img, radiusRange, ...
                                    objectPolarity, edgeThresh);

    %% Check if the accumulator array is all-zero
    if (~any(accumArray(:)))
        return;
    end                    

    %% Estimate the centers
    accumThresh = 1 - sensitivity;
    [centers, metric] = findCenters(accumArray, accumThresh);

    if (isempty(centers))
        return;
    end

    %% Retain circles with metric value greater than threshold 
     %corresponding to AccumulatorThreshold 

    idx2Keep = find(metric >= accumThresh);
    centers = centers(idx2Keep, :);
    metric = metric(idx2Keep, :);

    if (isempty(centers))
        centers = [];
        metric = [];
        return;
    end

    %% Estimate radii
    radiuses = findRadiuses(centers, accumArray, radiusRange);                
end





