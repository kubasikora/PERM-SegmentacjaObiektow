I = imread('../data/data2.jpg');

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

old_image = I;

for i=1:length(data)
    biggestCircleDiameter = 0;
    if (checkIfCircle(data(i)) == 1)
        if(data(i).EquivDiameter > biggestCircleDiameter)
            biggestCircleDiameter = data(i).EquivDiameter;
        end
    end
end

realBiggestCircleDiameter = 87;
px2mmRatio = realBiggestCircleDiameter / biggestCircleDiameter;

for i=1:length(data)
    if (checkIfCircle(data(i)) == 1)
        circle_count = circle_count + 1;
        new_image = addCircleInfo(old_image, data(i), px2mmRatio);
        old_image = new_image;
        
    elseif (checkIfPen(data(i)) == 1)
        pen_count = pen_count + 1;
        new_image = addPenInfo(old_image, data(i), px2mmRatio);
        old_image = new_image;
    end
end

imshow(new_image);

function [out] = checkIfCircle(shape)
    out = 0;
    if (shape.Eccentricity < 0.5)
        out = 1;
    end
end

function [out] = checkIfPen(shape)
    out = 0;
    if (shape.MajorAxisLength / shape.MinorAxisLength > 7)
        out = 1;
    end
end

function [withText] = addCircleInfo(original, shape, px2mmRatio)
    
    texts = cell(2,1);
    text{1} = ['Srednica: ' num2str(shape.EquivDiameter*px2mmRatio, '%0.2f') 'mm'];
    text{2} = ['Kolor: ' char(getColor(shape, original))];
    position = [shape.PixelList(1,1) shape.PixelList(1,2); shape.PixelList(1,1) shape.PixelList(1,2)+40];
    withText = insertText(original, position, text, 'FontSize', 24, 'BoxColor', 'yellow');
end

function [withText] = addPenInfo(original, shape, px2mmRatio)
    
    texts = cell(2,1);
    text{1} = ['Dlugosc: ' num2str(shape.MajorAxisLength*px2mmRatio,'%0.2f') 'mm'];
    text{2} = ['Orientacja: ' num2str(shape.Orientation,'%0.2f') '°'];
    text{3} = ['Kolor: ' char(getColor(shape, original))];
    position = [shape.PixelList(1,1) shape.PixelList(1,2); shape.PixelList(1,1) shape.PixelList(1,2)+40
        shape.PixelList(1,1) shape.PixelList(1,2)+80];
    
    withText = insertText(original, position, text, 'FontSize', 24, 'BoxColor', 'green');
end
