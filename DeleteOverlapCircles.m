function [circles] = DeleteOverlapCircles(circles)
    radiuses = zeros(length(circles), 1);
    
    for i = 1:length(circles)
        radiuses(i) = circles(i).radius;
    end
    
    radClustering = kmeans(radiuses, 2) - 1;
    radClustering = logical(mod(radClustering, 2));
    
    if (mean(radiuses(radClustering)) < ...
        mean(radiuses(~radClustering)) / 2) && ...
       (sum(radClustering) > 1 / 2 * length(radClustering))
    
        isCircleGood = radClustering;
        
    elseif (mean(radiuses(~radClustering)) < ...
            mean(radiuses(radClustering)) / 2) && ...
           (sum(radClustering) < 1 / 2 * length(radClustering))
        
        isCircleGood = ~radClustering;
        
    else
        return;
    end
    
    for i = 1:numel(circles)
        if ~isCircleGood(i)
            circleIsGoodFlag = true;
            
            for j = 1:numel(circles)
                if i ~= j && ...
                   pdist([circles(i).center; circles(j).center]) < ...
                   circles(i).radius
               
                    circleIsGoodFlag = false;
                    
                end
            end
            
            if circleIsGoodFlag
                isCircleGood(i) = true;
            end
        end
    end
    
    circles = circles(isCircleGood);
end

