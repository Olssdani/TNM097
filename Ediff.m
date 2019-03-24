function [Mean, Max, diff] = Ediff(Color,Ref)
%EDIFF Summary of this function goes here
%   Detailed explanation goes here

     diff = sqrt((Color(:,1)-Ref(:,1)).^2+(Color(:,2)-Ref(:,2)).^2+(Color(:,3)-Ref(:,3)).^2);
     Mean = mean(diff);
     Max = max(diff);
end

