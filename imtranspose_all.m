%IMTRANSPOSE_ALL Transpose all images in workspace
%   IMTRANSPOSE_ALL transposes all 2D, 3D and 4D images from the workspace to the
%   specified order as given by this script's initial variables (try 'edit
%   imtranspose_all')
%
%   Nade Sritanyaratana
%   University of Wisconsin, Madison
%   01/23/11
%   v1.0

S = whos;
%determine number of variables in current workspace
n = length(S);

for i=1:n
    eval(['currvar=' S(i).name ';']);
    %for current variable determine its dimension
    d = length(size(currvar));
    if d>=2
        eval([S(i).name '=imtranspose(' S(i).name ');']);
    end
end

clear S i currvar n d