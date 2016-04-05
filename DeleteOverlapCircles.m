function [circles] = DeleteOverlapCircles(circles)
    radiuses = zeros(length(circles), 1);
    for i = 1:length(circles)
        radiuses(i) = circles(i).radius;
    end
    radClustering = kmeans(radiuses, 2) - 1;
    radClustering = logical(mod(radClustering, 2));
    if mean(radiuses(radClustering)) < mean(radiuses(~radClustering)) / 2
        circles = circles(radClustering);
    elseif mean(radiuses(~radClustering)) < ...
            mean(radiuses(radClustering)) / 2
        circles = circles(~radClustering);
    end
end

