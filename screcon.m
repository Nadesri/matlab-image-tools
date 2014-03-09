function res=screcon(ims,smaps,obmask)

% res=screcon(ims,smaps,obmask)
%
% AS, 04/07, UWM

dims=size(ims);
if ~exist('obmask','var') || isempty(obmask)
    obmask=ones(dims(1:2));
end

sm0=selectData(smaps, obmask);
ims0=selectData(ims,obmask);
% NS: Why do we use mult_image below? Doesn't a simple .* work here? % NS: No. This allows multiplication for multiple slices? 
data=mult_image(sum(ims0.*conj(sm0),2),imdiv(sum(abs(sm0).^2,2)));
res=spreadData(data,obmask);

end