%IMFLIPUD_ALL Apply imflipud to all
%   IMFLIPUD_ALL flips all 3D and 4D variables in the current workspace in
%   the up/down direction.
%
%   Nade Sritanyaratana
%   University of Wisconsin, Madison
%   11/10/10
%   v1.0
%   v1.1 - possible typo from v1.0: added a semicolon for the 4D case


S = whos;
%determine number of variables in current workspace
n = length(S);

for i=1:n
    eval(['currvar=' S(i).name ';']);
    %for current variable determine its dimension
    d = length(size(currvar));
    if isnumeric(currvar)&&d==2
        eval([S(i).name '=imflipud(' S(i).name ');']);
    elseif isnumeric(currvar)&&d==3
        eval([S(i).name '=imflipud(' S(i).name ');']);
    elseif isnumeric(currvar)&&d==4
        for j=1:size(currvar,4)
            eval([S(i).name '(:,:,:,' int2str(j) ')  =imflipud(' S(i).name '(:,:,:,' int2str(j) '));']);
        end
    end
end

clear S i j currvar n d