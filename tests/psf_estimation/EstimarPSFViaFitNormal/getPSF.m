function psf = getPSF(im, psf_size, t)
    [val idx] = max(im(:));
    
    [row col] = ind2sub(size(im), idx);
    
    %psf = im2double(im(row-floor(psf_size/2):row+floor(psf_size/2), col-floor(psf_size/2):col+floor(psf_size/2)));
    psf = im(row-floor(psf_size/2):row+floor(psf_size/2), col-floor(psf_size/2):col+floor(psf_size/2));

    
    %psf = psf - (1.0+t)*min(psf(:));
    %psf(psf<=0) = 0;
    
    %psf = psf / sum(psf(:));
end