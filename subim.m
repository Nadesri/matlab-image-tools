function h=subim(i,j,k)
% SUB-IMAGE Produce figure with subplots of images
% h=subim(i,j,k) simply generates a subplot with specified i rows and j
% columns, with k being the current plot. h=subim(i,j,k) calls subaxis, a
% custom MATLAB function as found in the MATLAB Central File Exchange.
%
% h=subim(i,j,k) is not sophisticated in the sense that it merely hardcodes 
% specific parameters into the subaxis function. Its primary intended use
% is simply to shorten calls to subaxis and clean up excessively long
% commands.
%
% Nade Sritanyaratana
% Created March 2, 2012
% University of Wisconsin, Madison



h=subaxis(i,j,k,'SpacingHoriz', 0.008, 'PaddingRight', 0.002, 'PaddingLeft', 0.002, 'MarginRight', 0.002, 'MarginLeft', 0.002);