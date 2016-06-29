function apllyDeconvolutionsInFrames(PSF,path,maxNFrame)
    
    mkdir(path,'original');
    mkdir(path,'wnr');
    mkdir(path,'clsf');
    mkdir(path,'rl');

    for i=1:maxNFrame
       
        str = strcat(path,sprintf('%06d.png',i));
        im = imread(str);
        
        if(size(im,3) > 1)
            im = rgb2gray(im);
        end
        
        imgWnr = imadjust(deconvwnr(im, PSF,0.0005));
        imgCLSF = imadjust(deconvreg(im, PSF,0.0001));
        imgRL = imadjust(deconvlucy(im, PSF));
        
        imwrite(im,strcat(path,'original/',sprintf('%06d.png',i)));
        imwrite(imgWnr,strcat(path,'wnr/',sprintf('%06d.png',i)));
        imwrite(imgCLSF,strcat(path,'clsf/',sprintf('%06d.png',i)));
        imwrite(imgRL,strcat(path,'rl/',sprintf('%06d.png',i)));
        
    end

end