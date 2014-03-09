function figsquareaxis(ahandle)
% FIGSQUAREAXIS Set equal length axes
% figsquareaxis(ahandle) will set the figure with axis handle ahandle to 
% have the same length x axis and y axis. If fhandle is not specified,
% figsquareaxis(ahandle) will use the current figure.
%
% Nade Sritanyaratana
% University of Wisconsin, Madison
% March 29, 2011

if ~exist('ahandle','var')
    ahandle = gca;
end

daspect(ahandle, [1 1 1]);