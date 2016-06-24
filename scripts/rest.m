function out = rest(in, psf, deblur, valdeblur, denoise, valdenoise)
    
    in = im2double(in);

    if strcmp(deblur,'Wiener')
        aux = imadjust(deconvwnr(in,psf,valdeblur));
    elseif strcmp(deblur,'CLSF')
        aux = imadjust(deconvreg(in,psf,valdeblur));
    elseif strcmp(deblur,'RL')
        aux = imadjust(deconvlucy(in,psf));
    end
    
    if strcmp(denoise,'TV')
        aux = imadjust(cv.denoise_TVL1(uint8(255*aux),'Lambda',valdenoise));
    elseif strcmp(denoise,'BL')
        aux = imadjust(cv.bilateralFilter(255*aux),'SigmaSpace',10,'SigmaColor',valdenoise,'Diameter',11);
    elseif strcmp(denoise,'NLM')
        Options.kernelratio = 3;Options.windowratio = 7;Options.nThreads=8;Options.filterstrength=valdenoise;
        aux = imadjust(NLMF(aux,Options));
        %aux = imadjust(cv.fastNlMeansDenoising(uint8(255*aux),'H',valdenoise,'TemplateWindowSize',9,'SearchWindowSize',25));
    elseif strcmp(denoise,'BM3D')
        [NA aux] = BM3D(1,aux,valdenoise);
        aux = imadjust(aux);
    end
        
    out = aux;
    imshow(out,[]);

end