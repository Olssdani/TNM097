function [RGB] = WhitePoint(Image)
           imshow(Image);
           %Get input from user
           [x,y] =ginput(1);
           %Round of x, y if the screen has been resized
           x = round(x);
           y = round(y);
           %Take a small area around the pixel and get the mean value
           RGB(1,1) = mean(mean(Image(y-2:y+2,x-2:x+2,1)));
           RGB(1,2) = mean(mean(Image(y-2:y+2,x-2:x+2,2)));
           RGB(1,3) = mean(mean(Image(y-2:y+2,x-2:x+2,3)));
end

