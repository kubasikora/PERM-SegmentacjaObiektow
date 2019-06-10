addpath ../
[image, grayImage] = loadImage('../data/data1.jpg');

blurred = imgaussfilt(grayImage, 6);
meanGray = mean(mean(grayImage)) / 255;
BW1 = edge(blurred, 'canny', [0.1 0.14]);
imshow(BW1);

edges = uint8( BW1(:,:,[1 1 1]) * 255 );
abc = segmentImage(edges);

