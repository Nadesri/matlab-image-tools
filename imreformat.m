function out = imreformat(in,option,res,fov)
% IMREFORMAT Reformat Image
% IMREFORMAT(IN,OPTION,RES,FOV) returns a 3D matrix that is a "reformat" of
% the 3D matrix IN, containing the same number of elements of IN. OPTION
% must be either 1 or 2 and corresponds to the number of permutations to
% reformat the image. RES is a struct containing the ints X, Y, and Z,
% specifying the physical resolution of the image. FOV is a struct
% containing the ints X, Y, and Z, specifying the physical field of view of
% the image. If RES or FOV are not specified, IMREFORMAT assumes that the
% resolution is isotropic and covers the same field of view in all
% directions.
%
% Written by: Nade Sritanyaratana
% University of Wisconsin-Madison
% Created February 02/23/13
% v1.0 - Created

if ~exist('res','var')
    res.x = 1; res.y = 1; res.z = 1;
end

if ~exist('fov','var')
    fov.x = 1; res.y = 1; res.z = 1;
end

if ~exist('in','var')||~exist('option','var')
    error('IN and OPTION must be specified in order to perform reformat')
end

