function [BestValue,BestIndex ] = Generic(ColorData,ColorRefLab, NrOfSamples, MaxGenerations)
    %Get ref values in XYZ
    ColorDataRefXYZ =lab2xyz(ColorRefLab);

    %Random different index seeds
    for i=1:1:NrOfSamples+1
        GeneIndex(i,:) = randperm(size(ColorData,1), NrOfSamples);
    
    end
 	
    
    for i=1:1:MaxGenerations
       
        % Calculate all deltaE values for the different seeds
        for j= 1:1:NrOfSamples+1
            %Create color matrix for the transformation
            ColorGene = ColorData(GeneIndex(j,:),:);
              
            %Create the matrix for transforming RGB to XYZ
            A = Optimize_poly(ColorGene', ColorDataRefXYZ(GeneIndex(j,:),:)');
            XYZ_cal_D65 =Polynomial_regression(ColorData',A)';
            LabData = xyz2lab(XYZ_cal_D65,'WhitePoint','d65');
            [Mean, Max, diff] = Ediff(LabData,ColorRefLab);
            Best(j,:) = [Mean, Max];
        end
        %FInd the Seed with the best Delta E
        [~, Index] = min(Best(:,1));
        
        
        %Save the best seed and make 20 seed based on the best
        GeneIndex(1,:)  = GeneIndex(Index,:);
        for i=2:1:NrOfSamples+1
            GeneIndex(i,:) = GeneIndex(1,:);
            GeneIndex(i,i-1) = randi([1 size(ColorData,1)],1,1);
        end
    end
    
    %Get the diff for the best
    ColorGene = ColorData(GeneIndex(1,:),:);
              
    %Create the matrix for transforming RGB to XYZ
    A = Optimize_poly(ColorGene', ColorDataRefXYZ(GeneIndex(1,:),:)');
    XYZ_cal_D65 =Polynomial_regression(ColorData',A)';
    LabData = xyz2lab(XYZ_cal_D65,'WhitePoint','d65');
    [Mean, Max, diff] = Ediff(LabData,ColorRefLab);
    
    
    BestValue =Best(Index,:);
    BestIndex = GeneIndex(1,:);

end

