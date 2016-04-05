function [imgPrerocessed] = PreprocessImage(img)
    imgGray = rgb2gray(img);
    
    imgGray = medfilt2(imgGray);
    imgGray = imadjust(imgGray);
    PSF = fspecial('gaussian', 5, 10);
    imgBlurred = imfilter(imgGray, PSF, 'symmetric', 'conv');
    %imgCircuit = imsubtract(imgGray, imgBlurred);
    %imgPrerocessed = imadd(imgGray, 3 * imgCircuit); 
    imgPrerocessed = imgBlurred;
    %imshow(imgPrerocessed)
end

