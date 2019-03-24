%% Data
%Load in data
[HueColorRefXYZ,HueColorRefLab,HueColors, ColorRefXYZ, ColorRefLab, Colors,ColorRefV2XYZ, ColorV2RefLab, ColorsV2 ] = DataLoading();

%% Take away korrupt values
ColorV2RefLab(64,:) =[];
ColorV2RefLab(63,:) =[];
ColorV2RefLab(29,:) =[];

ColorRefV2XYZ(64,:) =[];
ColorRefV2XYZ(63,:) =[];
ColorRefV2XYZ(29,:) =[];
%% Calculate difference between White calibrated and not white calibrated and directly rgb to XYZ
%Convert patches to Cielab
HueColorsLab =rgb2lab(HueColors,'WhitePoint','d65');
[HueMean, HueMax] = Ediff(HueColorsLab,HueColorRefLab);

ColorsLab =rgb2lab(Colors,'WhitePoint','d65');
[ColorsMean, ColorsMax] = Ediff(ColorRefLab,ColorV2RefLab);

%% Calculate difference between White calibrated and not white calibrated and rgb->xyz->lab

HueColorsXYZ = rgb2xyz(HueColors,'WhitePoint','d65');
HueColorsLab = xyz2lab(HueColorsXYZ,'WhitePoint','d65');
[HueMean, HueMax] = Ediff(HueColorsLab,HueColorRefLab);


ColorsXYZ = rgb2xyz(Colors,'WhitePoint','d65');
ColorsLab = xyz2lab(ColorsXYZ,'WhitePoint','d65');
[ColorsMean, ColorsMax] = Ediff(ColorsLab,ColorRefLab);

ColorsV2XYZ = rgb2xyz(ColorsV2,'WhitePoint','d65');
ColorsV2Lab = xyz2lab(ColorsV2XYZ,'WhitePoint','d65');
[ColorsV2Mean, ColorsV2Max] = Ediff(ColorsV2Lab,ColorPatches);


%% Prim rose inversion
A = pinv(HueColors)*HueColorRefXYZ;
HueColorsXYZ =HueColors*A;
HueColorsLab = xyz2lab(HueColorsXYZ,'WhitePoint','d65');
[HueMean, HueMax] = Ediff(HueColorsLab,HueColorRefLab);

A = pinv(Colors)*ColorRefLab;
ColorsXYZ =Colors*A;
ColorsLab = xyz2lab(ColorsXYZ,'WhitePoint','d65');
[ColorsMean, ColorsMax] = Ediff(ColorsLab,ColorRefLab);

%% Regression

A = Optimize_poly(HueColors', HueColorRefXYZ');
HueColorsXYZ =Polynomial_regression(HueColors',A)';
HueColorsLab = xyz2lab(HueColorsXYZ,'WhitePoint','d65');
[HueMean, HueMax] = Ediff(HueColorsLab,HueColorRefLab);

A = Optimize_poly(Colors', ColorRefXYZ');
ColorsXYZ =Polynomial_regression(Colors',A)';
ColorsLab = xyz2lab(ColorsXYZ,'WhitePoint','d65');
[ColorsMean, ColorsMax] = Ediff(ColorsLab,ColorRefLab);

A = Optimize_poly(ColorsV2', ColorRefV2XYZ');
ColorsXYZ =Polynomial_regression(ColorsV2',A)';
ColorsLab = xyz2lab(ColorsXYZ,'WhitePoint','d65');
[ColorsV2Mean, ColorsV2Max] = Ediff(ColorsLab,ColorV2RefLab);

%% Signal dep Regression

A = Optimize_poly_SignalDep(HueColors', HueColorRefXYZ');
HueColorsXYZ =Polynomial_regression_SignalDep(HueColors',A)';
HueColorsLab = xyz2lab(HueColorsXYZ,'WhitePoint','d65');
[HueMean, HueMax] = Ediff(HueColorsLab,HueColorRefLab);

A = Optimize_poly_SignalDep(Colors', ColorRefXYZ');
ColorsXYZ =Polynomial_regression_SignalDep(Colors',A)';
ColorsLab = xyz2lab(ColorsXYZ,'WhitePoint','d65');
[ColorsMean, ColorsMax] = Ediff(ColorsLab,ColorRefLab);
%% Gentic
clear best
clear ColorIndex
[best, ColorIndex] = Generic(Colors,ColorRefLab, 40, 200);


%% Show Colors choosen
ColorsChosen = Colors(ColorIndex,:);
showRGB(ColorsChosen)








