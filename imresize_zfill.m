% IMRESIZE_ZFILL Resize image via zero fill
%
% out = imresize_zfill(in,size_out) resizes image IN by desired size 
% SIZE_OUT. size_out is a 1x3 vector specifying the number of desized rows, 
% columns, and slices. IMRESIZE_ZFILL uses a zero fill method in the 
% k-space domain to resize images.
%
% Now supports N-D images, so long as N>1 (14Sep2013)
%
% Currently, imresize_zfill can only enlargen images. It cannot shrink them.
%
% Nade Sritanyaratana
% University of Wisconsin-Madison
% Created August 14, 2013
% v1.0 - Created
% v1.1 - N-D support
% v2.0 - Now also resizes in the z-direction (9/27/13)

function [out kin2d kin3d]=imresize_zfill(in,size_out)

dims = size(in);
if length(dims)<3
    dims(3) = 1;
end

% Support for: Resize number of slices
if size_out(3)==1
    nslices = 1;
else
    nslices = size_out(3);
    size_out = size_out([1 2]);
    if nslices<size(in,3)
        error('IMRESIZE_ZFILL detected smaller number of slices in size_out compared to in, but IMRESIZE_ZFILL currently supports enlargement only (no shrinking.');
    end
end

% FIRST: Resize images in the x-y directions
out2d = zeros([size_out prod(dims(3:end))]);
for i=1:prod(dims(3:end))
    
    in_slice_i = in(:,:,i);
    vol_out = zeros(size_out);
    kin_slice_i = fft2(in_slice_i);
    % Add zeros at the center of the matrix, where high freqs lie, e.g.:
    %
    % From -
    %
    % TOP_L | TOP_R
    % -------------
    % BOT_L | BOT_R
    % 
    % To -
    % 
    % TOP_L 0 0 | 0 0 TOP_R
    % 0 0 0 0 0 | 0 0 0 0 0
    % 0 0 0 0 0 | 0 0 0 0 0
    % ---------------------
    % 0 0 0 0 0 | 0 0 0 0 0
    % 0 0 0 0 0 | 0 0 0 0 0
    % BOT_L 0 0 | 0 0 BOT_R
    %
    add0rows = size_out(1)-dims(1);
    add0cols = size_out(2)-dims(2);
    rows_half1 = 1:round(dims(1)/2);
    rows_half2 = (round(dims(1)/2)+1):dims(1);
    cols_half1 = 1:round(dims(2)/2);
    cols_half2 = (round(dims(2)/2)+1):dims(2);
    vol_out([rows_half1 rows_half2+add0rows],[cols_half1 cols_half2+add0cols]) = kin_slice_i;
    vol_out = ifft2(vol_out);

    energy_per_px_in  = sqrt(sum(in_slice_i(:).^2)/length(in_slice_i(:)));
    energy_per_px_out = sqrt(sum(vol_out(:).^2)/length(vol_out(:)));
    c = energy_per_px_in/energy_per_px_out;
    vol_out = abs(vol_out.*c);
    out2d(:,:,i) = vol_out;
    kin2d(:,:,i) = kin_slice_i;
end
out2d = reshape(out2d,[size_out dims(3:end)]);

% SECOND: Resize images in the slice direction
out = zeros([size_out nslices prod(dims(4:end))]);
for i_encode = 1:prod(dims(4:end))
    
    in_vol_i = fftn(out2d(:,:,:,i_encode));
    addslices = nslices-dims(3);
    slices_half1 = 1:round(dims(3)/2);
    slices_half2 = (round(dims(3)/2)+1):dims(3);
    
    vol_out = out(:,:,:,i_encode);
    vol_out(:,:,[slices_half1 addslices+slices_half2]) = in_vol_i;
    vol_out = ifftn(vol_out);
    
    energy_per_px_in  = sqrt(sum(in_vol_i(:).^2)/length(in_vol_i(:)));
    energy_per_px_out = sqrt(sum(vol_out(:).^2/length(vol_out(:))));
    c = energy_per_px_in/energy_per_px_out;
    vol_out = abs(vol_out.*c);
    out(:,:,:,i_encode) = vol_out;
    kin3d(:,:,:,i_encode) = in_vol_i;
end
out = reshape(out,[size_out nslices dims(4:end)]);
    
kin2d = reshape(kin2d,dims);
kin3d = reshape(kin3d,[size_out(1:2) dims(3:end)]);

end 


% function [out kin]=imresize_zfill(in,size_out)
% 
% dims = size(in);
% if length(dims)<3
%     dims(3) = 1;
% end
% 
% out = zeros([size_out prod(dims(3:end))]);
% for i=1:prod(dims(3:end))
%     
%     in_slice_i = in(:,:,i);
%     vol_out = zeros(size_out);
%     kin_slice_i = fft2(in_slice_i);
%     % Add zeros at the center of the matrix, where high freqs lie, e.g.:
%     %
%     % From -
%     %
%     % TOP_L | TOP_R
%     % -------------
%     % BOT_L | BOT_R
%     % 
%     % To -
%     % 
%     % TOP_L 0 0 | 0 0 TOP_R
%     % 0 0 0 0 0 | 0 0 0 0 0
%     % 0 0 0 0 0 | 0 0 0 0 0
%     % ---------------------
%     % 0 0 0 0 0 | 0 0 0 0 0
%     % 0 0 0 0 0 | 0 0 0 0 0
%     % BOT_L 0 0 | 0 0 BOT_R
%     %
%     add0rows = size_out(1)-dims(1);
%     add0cols = size_out(2)-dims(2);
%     rows_half1 = 1:round(dims(1)/2);
%     rows_half2 = (round(dims(1)/2)+1):dims(1);
%     cols_half1 = 1:round(dims(2)/2);
%     cols_half2 = (round(dims(2)/2)+1):dims(2);
%     vol_out([rows_half1 rows_half2+add0rows],[cols_half1 cols_half2+add0cols]) = kin_slice_i;
%     vol_out = ifft2(vol_out);
% 
%     energy_per_px_in  = sqrt(sum(in_slice_i(:).^2)/length(in_slice_i(:)));
%     energy_per_px_out = sqrt(sum(vol_out(:).^2)/length(vol_out(:)));
%     c = energy_per_px_in/energy_per_px_out;
%     vol_out = abs(vol_out.*c);
%     out(:,:,i) = vol_out;
%     kin(:,:,i) = kin_slice_i;
% end
% 
% out = reshape(out,[size_out dims(3:end)]);
% kin = reshape(kin,dims);
% 
% % rowstoadd = round((size_out(1)-size(in,1))/2);
% % colstoadd = round((size_out(2)-size(in,2))/2);
% % out  = zeros([rowstoadd*2+size(in,1) colstoadd*2+size(in,2) size(in,3)]);
% % kout = zeros([rowstoadd*2+size(in,1) colstoadd*2+size(in,2) size(in,3)]);
% % c = size_out(1)/size(in,1)*size_out(2)/size(in,2);
% % 
% % for z=1:size(in,3)
% %     kin = fft2(in(:,:,z));
% %     kin = fftshift(kin);
% %     kout((rowstoadd+1):(end-rowstoadd),(colstoadd+1):(end-colstoadd),z) = kin;
% %     out(:,:,z) = ifft2(fftshift(kout(:,:,z)))*c;
% % end
% 
% end 