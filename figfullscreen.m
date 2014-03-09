function figfullscreen(fhandle)
% FIGFULLSCREEN Bring a Figure to Fullscreen
% figfullscreen(fhandle) brings a figure with handle fhandle to fullscreen
% view, using the monitor's native resolution. If fhandle does not exist,
% figfullscreen(fhandle) will bring the current figure to fullscreen view.
%
% Nade Sritanyaratana
% University of Wisconsin-Madison
% March 29, 2011

if ~exist('fhandle','var')
    fhandle = gcf;
end

screensize = get(0,'ScreenSize'); %set up for fig full screen
set(fhandle,'Position', [0 0 screensize(3) screensize(4)]);
pop