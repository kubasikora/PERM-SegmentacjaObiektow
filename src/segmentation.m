I = imread('../data/data1.jpg');
%I = rgb2gray(I);
%I = imbinarize(I, 'adaptive');
%[Ibw1, ~] = createMask3(I);
[Ibw1, masked] = createMask3(I);
[Ibw, masked2] = createMask5(masked);

masked2Gray = rgb2gray(masked2);
[IbwS, maskedS] = segmentImage2(masked2Gray);
imshow(IbwS);

IbwFinal = imbinarize(Ibw1.*Ibw.*IbwS);
%imshow(IbwFinal);
[Ifinal, data] = filterRegions2(IbwFinal); 
