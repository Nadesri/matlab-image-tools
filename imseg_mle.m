function [out thresh im1 im2] = imseg_mle(in)
% IMAGE SEGMENTATION: Maximum Likelihood Estimation
% [out thresh im1 im2] = imseg_mle(in) segments an image in based on two 
% ROIs - the first being the region of interest, and the second being the
% region to remove. in must be an mxn matrix.
%
% This segmenation method applies maximum likelihood estimation to guess
% the best possible threshold. It further assumes that the regions follow a
% normal distribution.
%
% Nade Sritanyaratana
% University of Wisconsin, Madison
% Created October 19, 2011
% v1.0

imsc(mimsc(in)), title('1. Choose the region of interest')
im1 = roipoly;
imsc(mimsc(in)), title('2. Choose the region to remove')
im2 = roipoly;

pts1 = find(im1);
pts2 = find(im2);

% Define normal distributions
m1 = mean(in(pts1)); s1 = std(in(pts1));
m2 = mean(in(pts2)); s2 = std(in(pts2));

pts = find(in);
p1 = pdf('norm', in(pts), m1, s1);
p2 = pdf('norm', in(pts), m2, s2);

v = p1./p2 > 1;
out = zeros(size(in));
out(pts(v)) = 1;

x = linspace(m1,m2,2000);
pf1 = pdf('norm',x,m1,s1);
pf2 = pdf('norm',x,m2,s2);
test = (pf1-pf2).^2;
thresh = x(test==min(test));
thresh = thresh(1);