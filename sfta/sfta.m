function D = sfta(I, nt)
    I = im2uint8(I);
    if size(I,3) ~= 1
        I = rgb2gray(I);
    end;

    I = imadjust(I);
    
    T = otsurec( I, nt );
    dSize = numel(T) * 8;
    D = zeros(1, dSize);
    pos = 1;
    for t = 1 : numel(T)
        thresh = T(t);
        Ib = im2bw(I, thresh); 
        Iborder = findBorders(Ib);
        
        vals = double(I(Ib));
        
        D(pos) = hausDim(Iborder);
        pos = pos + 1;
        
        D(pos) = mean(vals);
        pos = pos + 1;

        D(pos) = numel(vals)./(size(I, 1) .* size(I, 2));
        pos = pos + 1;
        
        [~, D(pos)] = bwlabel(Ib);
        pos = pos + 1;
    end;
    
    T = [T; 1.0];
    range = getrangefromclass(I);
    range = range(2);
    
    for t = 1 : (numel(T) - 1)
        lowerThresh = T(t);
        upperThresh = T(t + 1);
            
        Ib = I > (lowerThresh * range) & I < (upperThresh * range);
        Iborder = findBorders(Ib);
        
        vals = double(I(Ib));
        
        D(pos) = hausDim(Iborder);
        pos = pos + 1;
        
        D(pos) = mean(vals);
        pos = pos + 1;

        D(pos) = numel(vals)./(size(I, 1) .* size(I, 2));
        pos = pos + 1;
        
        [~, D(pos)] = bwlabel(Ib);
        pos = pos + 1;
    end;
end