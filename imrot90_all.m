%IMROT90_ALL Apply imrot90 to all
%   IMROT90_ALL applies imrot90 to all 3D and 4D matrices in the current
%   workspace.
%
%   Nade Sritanyaratana
%   University of Wisconsin, Madison
%   February 8, 2011
%   v1.0


S = whos;
%determine number of variables in current workspace
n = length(S);

for i=1:n
    eval(['currvar=' S(i).name ';']);
    %for current variable determine its dimension
    d = length(size(currvar));
    if ~(isnumeric(currvar)||islogical(currvar))
        % do nothing
    elseif d==2
        eval([S(i).name '=imrot90(' S(i).name ');']);
    elseif d==3
        eval([S(i).name '=imrot90(' S(i).name ');']);
    elseif d==4
        for j=1:size(currvar,4)
            eval([S(i).name '(:,:,:,' int2str(j) ')  =imrot90(' S(i).name '(:,:,:,' int2str(j) '));']);
        end
    end
end

clear S i j currvar n d