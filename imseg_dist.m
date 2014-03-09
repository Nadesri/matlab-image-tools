function out = imseg_dist(in,z,nstd);
% IMSEG_DIST Image Segmentation: Distribution-based
%   out = imseg_dist(in,z,nstd) uses mxnxz image in and a user
%   input-generated ROI to determine the intensity distribution of interest
%   to segment from the rest of the image. z must be an array of indices
%   indicating which slices to use for the user-input ROI prompt.
%
%   nstd is an optional integer-valued input that determines how many 
%   standard deviations the intensity range should span. Default is 2.
%
%   Nade Sritanyaratana
%   Created November 11, 2011
%   University of Wisconsin, Madison
%   v1.0

if ~exist('nstd','var')
    nstd = 2;
end

roivals = []; figure
for i=1:length(z)
    imsc(mimsc(in(:,:,z(i))))
    title(['Select the ROI of interest. You are currently at slice ' int2str(z(i)) ...
        ' and have ' int2str(length(z)-i) ' slices to go.'])
    mask = roipoly;
    mask = in(:,:,i).*mask;
    roivals = [roivals; mask(:)];
end
close

roimean = mean(roivals);
roistd = std(roivals);

out = (in>(roimean-roistd*nstd)).*(in<(roimean+roistd*nstd));