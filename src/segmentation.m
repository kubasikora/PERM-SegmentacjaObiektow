I = imread('../data/DataSimplified1.jpg');
I = rgb2gray(I);
I = imbinarize(I, 'adaptive');
imshow(I);