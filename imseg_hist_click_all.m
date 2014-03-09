%IMSEG_HIST_CLICK_ALL Apply imseg_hist_click to all
%   IMSEG_HIST_CLICK_ALL applies imseg_hist_click to all 3D matrices in the
%   current workspace.
%
%   Nade Sritanyaratana
%   University of Wisconsin, Madison
%   February 27, 2011

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
        eval([S(i).name '=imseg_hist_click(' S(i).name ',0,600);']);
    end
end

clear S i j currvar n d