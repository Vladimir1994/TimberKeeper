function [IDX, isnoise] = dbscanCircles(circles, MinPts)

    centers = zeros(length(circles), 2);
    radiuses = zeros(length(circles), 1);
    for i = 1:length(circles)
        centers(i, :) = circles(i).center;
        radiuses(i, :) = circles(i).radius;
    end
    
    epsilon = mean(radiuses);

    C = 0;
    
    n = size(centers, 1);
    IDX = zeros(n, 1);
    
    D = pdist2(centers, centers);
    
    for i = 1:n
        for l = 1:n
            if i ~= l
                D(i, l) = D(i, l) - radiuses(i) - radiuses(l);
            end
        end
    end
    
    visited = false(n, 1);
    isnoise = false(n, 1);
    
    for i = 1:n
        if ~visited(i)
            visited(i) = true;
            
            Neighbors = RegionQuery(i);
            if numel(Neighbors) < MinPts
                isnoise(i) = true;
            else
                C = C + 1;
                ExpandCluster(i, Neighbors, C);
            end
        end
    end
    
    function ExpandCluster(i, Neighbors, C)
        IDX(i) = C;
        
        k = 1;
        while true
            j = Neighbors(k);
            
            if ~visited(j)
                visited(j) = true;
                Neighbors2 = RegionQuery(j);
                if numel(Neighbors2) >= MinPts
                    Neighbors = [Neighbors, Neighbors2];
                end
            end
            if IDX(j) == 0
                IDX(j) = C;
            end
            
            k = k + 1;
            if k > numel(Neighbors)
                break;
            end
        end
    end
    
    function Neighbors = RegionQuery(i)
        Neighbors = find(D(i, :) <= epsilon);
    end

end


