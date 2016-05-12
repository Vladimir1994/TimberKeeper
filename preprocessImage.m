function imgPrerocessed = preprocessImage(img)
    imgGray = rgb2gray(img);
    
    imgGray = imadjust(imgGray);
    
    imgGray = medfilt2(imgGray);
    PSF = fspecial('gaussian', 5, 10);
    imgBlurred = imfilter(imgGray, PSF, 'symmetric', 'conv');
    imgPrerocessed = imgGray;
end

