%IMSEG_HIST_ALL Apply imseg_hist to all
%   IMSEG_HIST_ALL applies imseg_hist to all 3D matrices in the current
%   workspace.
%
%   Nade Sritanyaratana
%   University of Wisconsin, Madison
%   February 17, 2011
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
    elseif d==3
        eval([S(i).name '=imseg_hist(' S(i).name ',0,1000,3000);']);
    end
end

clear S i j currvar n d