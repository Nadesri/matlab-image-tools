function im = iminsert(in,bgim)
% INSERT IMAGE
%   im = iminsert(in,bgim) overlays nxn matrix on background nxn matrix 
%   image bgim. iminsert preserves the values of in, and modifies the
%   values of bgim. For best results, in should be a sparce nxn matrix,
%   while bgim relatively nonsparce.
%
%   See also IMOVERLAY.
%
%   Nade Sritanyaratana
%   September 29, 2011
%   University of Wisconsin, Madison
%   v1.0 - Initialized

pts = find(in);
bgim(pts) = 0;
bgim = bgim/max(bgim(:))*mean(nonzeros(in));

im = zeros(size(in));
im = in+bgim;