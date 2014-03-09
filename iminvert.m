function out = iminvert(in)
% IMINVERT invert image intensities
%   out = iminvert(in) will "flip" the high-low intensities so that all
%   high pixels take on the values of the low pixel intensities, and vice
%   versa. in can be an mxnxz image.
%
%   Nade Sritanyaratana
%   Created November 11, 2011
%   University of Wisconsin, Madison
%   v1.0

imax = max(in(:));
imin = min(in(:));

out = -1*in+imax+imin;