function [ColorChart] = ImageProcessing(NrOfImages)
    %Read all images and return just one rgb value for each image. The area
    %of the image that is taken is chosed by the user. The colorvalue is a
    %mean value of an area of 3*3 pixels.
    ColorChartV2 = zeros(NrOfImages,3);
    for i=1:1:NrOfImages
        %Lost data
        %if(i ~=29 && i ~=63&&i ~=64) 
            i
           %Create filename
           filename = sprintf('Ny_Klar/%d%s',i, '.dng');
           %Read image and make to double
           Im = im2double(imread(filename));
           imshow(Im);
           %Get input from user
           [x,y] =ginput(1);
           %Round of x, y if the screen has been resized
           x = round(x);
           y = round(y);
           %Take a small area around the pixel and get the mean value
           RGB(1,1) = mean(mean(Im(y-1:y+1,x-1:x+1,1)));
           RGB(1,2) = mean(mean(Im(y-1:y+1,x-1:x+1,2)));
           RGB(1,3) = mean(mean(Im(y-1:y+1,x-1:x+1,3)));

           ColorChartV2(i,:)= RGB;
       % else
       %       ColorChart(i,:)= [0,0,0];
       % end
        
    end
    save('ColorsV2.mat','ColorChartV2')
    
    
    
end

