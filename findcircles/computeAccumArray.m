function [accumMatrix] = computeAccumArray(img, ...
                                           radiusRange, ...
                                           objectPolarity, ...
                                           edgeThresh)

    maxNumElemNHoodMat = 1e6;

    %% Get edge pixels
    img = im2single(img);
    [Gx, Gy, gradientImg] = imgradient(img);
    [Ex, Ey] = getEdgePixels(img, edgeThresh);

    idxE = sub2ind(size(img), Ey, Ex);

    %% Identify different radii for votes
    if (length(radiusRange) > 1)
        radiusRange = radiusRange(1):0.5:radiusRange(2);
    end
    if(strcmp(objectPolarity, 'bright'))
        RR = radiusRange;
    elseif(strcmp(objectPolarity, 'dark'))
        RR = -radiusRange;
    else
        error('bad polarity')
    end

    %% Compute the weights for votes for different radii

    if (length(radiusRange) > 1)
        lnR = log(radiusRange);
        phi = ((lnR - lnR(1)) / (lnR(end) - lnR(1)) * 2 * pi) - pi;
    else
        phi = 0;
    end
    Opca = exp(sqrt(-1) * phi);
    w0 = Opca ./ (2 * pi * radiusRange);


    %% Computing the accumulator array

    xcStep = floor(maxNumElemNHoodMat / length(RR));
    lenE = length(Ex);
    [M, N] = size(img);
    accumMatrix = zeros(M, N);

    for i = 1:xcStep:lenE
        Ex_chunk = Ex(i:min(i + xcStep - 1, lenE));
        Ey_chunk = Ey(i:min(i + xcStep - 1, lenE));
        idxE_chunk = idxE(i:min(i + xcStep - 1, lenE));

        xc = bsxfun(@plus, Ex_chunk, bsxfun(@times, -RR, ...
            Gx(idxE_chunk) ./  gradientImg(idxE_chunk))); 
        yc = bsxfun(@plus, Ey_chunk, bsxfun(@times, -RR, ... 
            Gy(idxE_chunk) ./ gradientImg(idxE_chunk)));
      
        xc = round(xc);
        yc = round(yc);

        w = repmat(w0, size(xc, 1), 1);

        %% Determine which edge pixel votes are within the image domain
        [M, N] = size(img);
        inside = (xc >= 1) & (xc <= N) & (yc >= 1) & (yc < M);

        rows_to_keep = any(inside, 2);
        xc = xc(rows_to_keep, :);
        yc = yc(rows_to_keep, :);
        w = w(rows_to_keep, :);
        inside = inside(rows_to_keep, :);

        %% Accumulate the votes in the parameter plane
        xc = xc(inside); 
        yc = yc(inside);
        accumMatrix = accumMatrix + accumarray([yc(:), xc(:)], ...
                                               w(inside), [M, N]);
        clear xc yc w;
    end

end

function [Gx, Gy, gradientImg] = imgradient(I)

    hy = -fspecial('sobel');
    hx = hy';

    Gx = imfilter(I, hx, 'replicate','conv');
    Gy = imfilter(I, hy, 'replicate','conv');

    gradientImg = hypot(Gx, Gy);
end

function [Ex, Ey, ExMat, EyMat, edgeImg] = getEdgePixels(img, edgeThresh)
    edgeImg = double(edge(img, 'Canny', edgeThresh));
    ExMat = double(edge(img, 'Canny', edgeThresh, 'horizontal'));
    EyMat = double(edge(img, 'Canny', edgeThresh, 'vertical'));
    %imshow(edgeImg)
    [Ey, Ex] = find(edgeImg);
end


