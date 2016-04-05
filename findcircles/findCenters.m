function [centers, metric] = findCenters(accumMatrix, accumThresh)

    medFiltSize = 5;
 
    centers = [];
    metric = [];
    %% Use the magnitude - Accumulator array can be complex. 
    accumMatrix = abs(accumMatrix);

    %% Pre-process the accumulator array
    if (min(size(accumMatrix)) > medFiltSize)
        Hd = medfilt2(accumMatrix, [medFiltSize medFiltSize]);
    else
        Hd = accumMatrix;
    end

    accumThresh = max(accumThresh - eps(accumThresh), 0);
    Hd = imhmax(Hd, accumThresh);
    bw = imregionalmax(Hd);
    s = regionprops(bw, accumMatrix, 'weightedcentroid');

    %% Sort the centers based on their accumulator array value
    if (~isempty(s))
        centers = reshape(cell2mat(struct2cell(s)), 2, length(s))';
        [rNaN, ~] = find(isnan(centers));
        centers(rNaN, :) = [];

        if(~isempty(centers))
            metric = Hd(sub2ind(size(Hd), round(centers(:, 2)), ...
                                                round(centers(:, 1))));
            [metric, sortIdx] = sort(metric, 1, 'descend');
            centers = centers(sortIdx, :);
        end
    end

end





