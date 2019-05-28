I = imread('../data/data1.jpg');

I = imgaussfilt(I, 5);

[Ibw1, masked] = maskHSV(I);
[Ibw, masked2] = maskLAB(masked);

masked2Gray = rgb2gray(masked2);
[IbwS, maskedS] = segmentImage(masked2Gray);

IbwFinal = imbinarize(Ibw1.*Ibw.*IbwS);
imshow(IbwFinal);
[Ifinal, data] = filterRegions(IbwFinal); 

circle_count = 0;
pen_count = 0;

for i=1:length(data)
    if (checkIfCircle(data(i)) == 1)
        circle_count = circle_count + 1;
    elseif (checkIfPen(data(i)) == 1)
        pen_count = pen_count + 1;
    end
end


function [out] = checkIfCircle(shape)
    out = 0;
    if (shape.Eccentricity < 0.5)
        out = 1;
    end
end

function [out] = checkIfPen(shape)
    out = 0;
    if (shape.MajorAxisLength / shape.MinorAxisLength > 5)
        out = 1;
    end
end