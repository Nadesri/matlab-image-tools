function out=imoutline(in)
% IMOUTLINE Generate Image Outline
% out=IMOUTLINE(in) produces an outline of the 3D image in. More 
% specifically, for an mxnxz image in, the outline out is an mxnxz image of 
% 1s and 0s. This outline will try to wrap around the nonzero elements of 
% in for each slice in z without touching a nonzero element of in.
%
% Nade Sritanyaratana
% University of Wisconsin-Madison
% Written March 29, 2012
% v1.0
% v1.1 - Clarified help text. (4/17/12)

out = zeros(size(in));
    for i=1:size(in,3)
        out(:,:,i) = bwperim(in(:,:,i));
        % Below is deprecated in favor of bwperim...
%         vout = voutline(in(:,:,i));
%         hout = houtline(in(:,:,i));
%         out(:,:,i) = (vout+hout)>0;
    end
end

function out=voutline(in)
    for i=1:size(in,2)
        imc = in(:,i);
        imco = zeros(size(imc));
        adj1 = find(imc,1)~=size(in,2);
        adj2 = find(imc,1,'last')~=size(in,2);
        imco([find(imc,1)-adj1 find(imc,1,'last')+adj2]) = 1;
        out(:,i) = imco;
    end
end

function out=houtline(in)
    for i =1:size(in,1)
        imr = in(i,:);
        imro = zeros(size(imr));
        adj1 = find(imr,1)~=size(in,1);
        adj2 = find(imr,1,'last')~=size(in,1);
        imro([find(imr,1)-adj1 find(imr,1,'last')+adj2]) = 1;
        out(i,:) = imro;
    end
end