function colorName = getColor(shape, I)
    [listSize x] = size(shape.PixelList);
    redSum = 0;
    greenSum = 0;
    blueSum = 0;
    for i=1:listSize
        x = shape.PixelList(i,2);
        y = shape.PixelList(i,1);
        px = I(x,y, :);
        redSum = redSum + double(px(1,1,1));
        greenSum = greenSum + double(px(1,1,2));
        blueSum = blueSum + double(px(1,1,3));
    end
    
    redAvg = redSum / listSize;
    greenAvg = greenSum / listSize;
    blueAvg = blueSum / listSize;

    colors = [ 
        255, 255, 255;
        255, 0, 0;
        255, 255, 0;
        0, 255, 0;
        0, 0, 255;
        184, 3, 255;
        255, 204, 221;
        192, 192, 192;
        127, 225, 212;
        0, 255, 255;
    ];
    
    names = ['bialy'; 
        "czerwony"; 
        "zolty"; 
        "zielony"; 
        "niebieski"; 
        "fioletowy";
        "rozowy"; 
        "srebrny"; 
        "akwamaryna"; 
        "cyjan";];
    
    errors = zeros(size(names, 1), 1);
    for color=1:size(colors)
        col = colors(color, :);
       
        errors(color) = (col(1) - redAvg).^2 + (col(2) - greenAvg).^2 + (col(3) - blueAvg).^2;
    end
    
    [~, colorIndex] = min(errors);
    colorName = names(colorIndex); 
end
