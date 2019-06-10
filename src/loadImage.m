function [image, grayImage] = loadImage(path)
    image = imread(path);
    grayImage = rgb2gray(image);
end

