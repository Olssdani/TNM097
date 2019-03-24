function [HueColorRefXYZ,HueColorRefLab,HueColors, ColorRefXYZ, ColorRefLab, Colors,ColorRefV2XYZ, ColorV2RefLab, ColorsV2 ] = DataLoading()
    %Load referens data for the HueColor
    load('HueColor.mat');
    HueColorRefLab = HueColor;
    %Load the data for the HueColors
    load('HueColorsData.mat');
    HueColors = ColorChart;
    %Load the data for the Colors
    load('ColorChart.mat');
    Colors = ColorChart;
    %Load referens data for the Color
    load('ColorPatches.mat');
    ColorRefLab  = ColorPatches;
    
    load('ColorsV2.mat');
    ColorsV2 = ColorChartV2;
    %Load referens data for the Color
    fileID = fopen('Meusure_M0.txt','r');
    formatSpec = '%f';
    sizeA = [3 Inf];
    ColorV2RefLab = fscanf(fileID,formatSpec,sizeA)';
    fclose(fileID);
    ColorV2RefLab(130,:) =[];
    
    
    
    %Clear variables
    clear ColorChart
    clear HueColor
    clear ColorPatches
    clear ColorChartV2
    
    % Calibrate for the white point
    W = im2double(imread('HueColors/vit.dng'));
    WhiteRGB = WhitePoint(W);
    clear W;
    HueColors = HueColors./WhiteRGB;
    HueColors(HueColors>1) = 1.0;
    
    W = im2double(imread('Traindata/vit.dng'));
    WhiteRGB = WhitePoint(W);
    clear W;
    Colors = Colors./WhiteRGB;
    Colors(Colors>1) = 1.0;
    
    W = im2double(imread('Ny_Klar/vit.dng'));
    WhiteRGB = WhitePoint(W);
    clear W;
    ColorsV2 = ColorsV2./WhiteRGB;
    ColorsV2(ColorsV2>1) = 1.0;
    
    
    
    
    
    % Get XYZ ref for both colors
    HueColorRefXYZ = lab2xyz(HueColorRefLab);
    ColorRefXYZ = lab2xyz(ColorRefLab);
    ColorRefV2XYZ = lab2xyz(ColorV2RefLab);

    
    
    
    
end

