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
    
    if (checkIfCircle(data(i)) == 1)
        circle_count = circle_count + 1;
        new_image = addCircleInfo(old_image, data(i));
        old_image = new_image;
    elseif (checkIfPen(data(i)) == 1)
        pen_count = pen_count + 1;
        new_image = addPenInfo(old_image, data(i));
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
    if (shape.MajorAxisLength / shape.MinorAxisLength > 5)
        out = 1;
    end
end

function [withText] = addCircleInfo(original, shape)
    
    text = ['�rednica: ' num2str(shape.EquivDiameter,'%0.2f') 'px'];
    position = [shape.PixelList(1,1) shape.PixelList(1,2)];
    
    withText = insertText(original, position, text, 'FontSize', 24, 'BoxColor', 'yellow');
end

function [withText] = addPenInfo(original, shape)
    
    texts = cell(2,1);
    text{1} = ['D�ugo��: ' num2str(shape.MajorAxisLength,'%0.2f') 'px'];
    text{2} = ['Orientacja: ' num2str(shape.Orientation,'%0.2f') '�'];
    position = [shape.PixelList(1,1) shape.PixelList(1,2); shape.PixelList(1,1) shape.PixelList(1,2)+40];
    
    withText = insertText(original, position, text, 'FontSize', 24, 'BoxColor', 'green');
end
