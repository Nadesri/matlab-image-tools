function segim = seg_hist_click(im, option, Teps, N)
% IM_HIST_CLICK Segment Image via Clicking on Histogram
% segim = imseg_hist(im) segments an image and returns it as the output.
% imseg_hist is designed for spgr and afi raw images, but may work on other
% raw images as well. The segmentation can remove background noise and
% possibly some tissue, leaving most of the tissue intact. The success of
% this segmentation relies on the user's click input.
%
% segim = imseg_hist(im, option) allows the user control of which direction
% to segment. select option='lt' to select only those values less than the
% click position. select option='gt' to select those values greater than
% the click position. By default, imseg_hist_click will select those values
% greater than the click position.
%
% segim = imseg_hist(im, option, Teps) will increase the threshold of the image by
% Teps. This is designed to skew the threshold beyond the default threshold
% T, where T is the selected point from the interactive click (most likely 
% in the middle of the two "noise" and "signal" distributions). To NOT use
% Teps, just set Teps=0.
%
% segim = imseg_hist(im, option, Teps, N) will modify the setup for the histogram 
% creation stage. N is the number of bins in counts = hist(im(:),N).
%
% University of Wisconsin-Madison
% Nade Sritanyaratana
% Created: February 27, 2011
% v1.0 (02/27/11)

if ~exist('Teps','var')
    Teps = 0;
end
if ~exist('N','var')
    N=round(300/(224*224*20)*numel(im));
end
if ~exist('option','var')
    option='gt';
end

h1 = figure; imsc(mimsc(im));
imlist = nonzeros(im(:)); imlist = sort(imlist,1);

%remove outliers from imlist
 % Categorize quadrants
 n = length(imlist);
 q1 = imlist(1:round(n/4));
 q2 = imlist(round(n/4)+1:round(2*n/4));
 q3 = imlist(round(2*n/4)+1:3*round(n/4));
 q4 = imlist(round(3*n/4)+1:end);
 % Define Outlier Thresh
 qrange = q3(end)-q2(1);
 outlierthresh = median(imlist)+qrange*1;
 % Oust outliers
 length(imlist)
 imlist = imlist.*(imlist>outlierthresh); imlist = nonzeros(imlist);
 length(imlist)

[Y X] = hist(imlist,N);
h2 = figure; bar(X,Y)
[x y] = ginput(1);
close(h1), close(h2),
T       = x;
That    = T+Teps;

if strcmp(option,'gt')
    segim   = (im>That).*im;
elseif strcmp(option,'lt')
    segim   = (im<That).*im;
else
    segim   = (im>That).*im;
end