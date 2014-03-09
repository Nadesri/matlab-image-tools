function mask = roisplitudnp(in,np)
% SPLIT REGION OF INTEREST by np regions- UP/DOWN
%   [mask1 mask2] = roisplitudn(in,np) splits the mxnxz mask by NP pieces,
%   from top and bottom, and creates NP mxnxz matrices indexed in mask{i},
%   respectively.
%
%   Nade Sritanyaratana
%   Created September 4, 2012
%   University of Wisconsin, Madison
%   v1.0 - Derived from roisplitus (v1.1)

z = size(in,3);
for i=1:np
    mask{i} = zeros(size(in));
end


for m=1:z
    inz = in(:,:,m);
    for n=1:size(inz,2)
        ptop=find(inz(:,n),1);
        pbottom=find(inz(:,n),1,'last');
        if or(and(isempty(ptop),isempty(pbottom)),ptop==pbottom)
            continue
        else
            parray = round(linspace(ptop,pbottom,np+1));
            for i=1:np
                p1 = parray(i); %top of piece i
                p2 = parray(i+1); %bottom of piece i
                p1 = p1+(i~=1); %avoids pixel overlap
                mask{i}(p1:p2,n,m) = true;
            end
        end
    end
end

for i=1:np
    mask{i} = logical(mask{i}.*in);
end