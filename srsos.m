function img_out = srsos(img_in, dim)
%SRSOS Square Root Sum of Squares
% img_out = srsos(img_in, dim) for a given dim (by default 3)

if ~exist('dim','var')
    dim = 3;
end

img_out = squeeze(sqrt(sum(img_in.*conj(img_in),dim)));

end

