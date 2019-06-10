clear all
close all
[image, grayImage] = loadImage('../data/data1.jpg');

figure
hold on
title('Oryginalny obraz do analizy');
imshow(image);
hold off

figure
hold on
title('Obraz w skali szarości');
imshow(grayImage);
hold off

%% color thresholder
[binaryMask, image] = simpleMask(image);

figure
hold on
title('Obraz po progowaniu kolorów');
imshow(image);
hold off


%% segmentacja 

[bw, image]= segmentImage(image);

figure
hold on
title('Obraz po segmentacji');
imshow(image);
hold off