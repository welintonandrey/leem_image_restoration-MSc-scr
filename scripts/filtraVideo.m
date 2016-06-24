function filtraVideo(nameVideo,pathVideo, pathResults, PSF, maxTotalReadFrames)
    str = sprintf(nameVideo);
    disp(str);
    
    % Read file
    str = sprintf('Reading file...');
    disp(str);
    
    videoReader = VideoReader(pathVideo);

    % Convert File
    str = sprintf('Convert file...');
    disp(str);

    videoReader.CurrentTime = 0;
    count = 1;
    while (hasFrame(videoReader) && maxTotalReadFrames >= count)
        img = rgb2gray(readFrame(videoReader)); 
        auxVideo{count} = img;
        count = count + 1;
    end
    video = zeros(size(auxVideo{1},1),size(auxVideo{1},2),size(auxVideo,2));

    for i=1:size(auxVideo,2) ; video(:,:,i) = auxVideo{i}; end
    clear auxVideo
    clear videoReader
    video = uint8(video);
    
    % Apply deblur + denoising
    str = sprintf('Apply deblur + denoising...');
    disp(str);
    
    %---------------------------------------------
    %   Video original
    str = sprintf('Saving copy original video...');
    disp(str);
    v = VideoWriter(strcat(pathResults,nameVideo,'-original.avi'));
    open(v)
    for i = 1:size(video,3)
        %Write frame in file
        writeVideo(v,video(:,:,i));
    end
    close(v)
    
    %---------------------------------------------
    %   TV
    str = sprintf('Running TV...');
    disp(str);
    v = VideoWriter(strcat(pathResults,nameVideo,'-TV.avi'));
    open(v)
    for i = 1:size(video,3)
        %Denoising
        img = cv.denoise_TVL1(uint8(video(:,:,i)),'Lambda',1.3);
        %Write frame in file
        writeVideo(v,img);
        clear img
    end
    close(v)
    
    %---------------------------------------------
    %   Bilateral
    str = sprintf('Running Bilateral...');
    disp(str);
    v = VideoWriter(strcat(pathResults,nameVideo,'-Bilateral.avi'));
    open(v)
    for i = 1:size(video,3)
        %Denoising
        img = cv.bilateralFilter(uint8(video(:,:,i)),'SigmaSpace',10,'SigmaColor',31,'Diameter',11);
        %Write frame in file
        writeVideo(v,img);
        clear img
    end
    close(v)
    
    %---------------------------------------------
    %   NLM
    Options.kernelratio = 3;Options.windowratio = 7;Options.nThreads=8;Options.filterstrength=0.07;

    str = sprintf('Running NLM...');
    disp(str);
    v = VideoWriter(strcat(pathResults,nameVideo,'-NLM.avi'));
    open(v)
    for i = 1:size(video,3)
        %Denoising
        img = NLMF(im2double(video(:,:,i)),Options);        
        %Write frame in file
        writeVideo(v,uint8(img*255));
        clear img
    end
    close(v)
    
    %---------------------------------------------
    %   BM3D
    str = sprintf('Running BM3D...');
    disp(str);
    v = VideoWriter(strcat(pathResults,nameVideo,'-BM3D.avi'));
    open(v)
    for i = 1:size(video,3)
        %Denoising
        [NA img] = BM3D(1,uint8(video(:,:,i)),16);       
        %Write frame in file
        writeVideo(v,img);
        clear img
    end
    close(v)
    
    %---------------------------------------------
    %   TV + Wiener
    str = sprintf('Running TV + Wiener...');
    disp(str);
    v = VideoWriter(strcat(pathResults,nameVideo,'-TV_Wiener.avi'));
    open(v)
    for i = 1:size(video,3)
        %Deblur
        img = imadjust(deconvwnr(video(:,:,i), PSF,0.0005));
        %Denoising
        img = cv.denoise_TVL1(uint8(img),'Lambda',1.2);
        %Write frame in file
        writeVideo(v,img);
        clear img
    end
    close(v)
    
    %---------------------------------------------
    %   TV + CLSF
    str = sprintf('Running TV + CLSF...');
    disp(str);
    v = VideoWriter(strcat(pathResults,nameVideo,'-TV_CLSF.avi'));
    open(v)
    for i = 1:size(video,3)
        %Deblur
        img = imadjust(deconvreg(video(:,:,i), PSF,0.0001));
        %Denoising
        img = cv.denoise_TVL1(uint8(img),'Lambda',1.2);
        %Write frame in file
        writeVideo(v,img);
        clear img
    end
    close(v)
    
    %---------------------------------------------
    %   TV + RL
    str = sprintf('Running TV + RL...');
    disp(str);
    v = VideoWriter(strcat(pathResults,nameVideo,'-TV_RL.avi'));
    open(v)
    for i = 1:size(video,3)
        %Deblur
        img = imadjust(deconvlucy(video(:,:,i), PSF));
        %Denoising
        img = cv.denoise_TVL1(uint8(img),'Lambda',1.2);
        %Write frame in file
        writeVideo(v,img);
        clear img
    end
    close(v)
    
    %---------------------------------------------
    %   Bilateral + Wiener
    str = sprintf('Running Bilateral + Wiener...');
    disp(str);
    v = VideoWriter(strcat(pathResults,nameVideo,'-Bilateral_Wiener.avi'));
    open(v)
    for i = 1:size(video,3)
        %Deblur
        img = imadjust(deconvwnr(video(:,:,i), PSF,0.0005));
        %Denoising
        img = cv.bilateralFilter(uint8(img),'SigmaSpace',10,'SigmaColor',25,'Diameter',11);
        %Write frame in file
        writeVideo(v,img);
        clear img
    end
    close(v)
    
    %---------------------------------------------
    %   Bilateral + CLSF
    str = sprintf('Running Bilateral + CLSF...');
    disp(str);
    v = VideoWriter(strcat(pathResults,nameVideo,'-Bilateral_CLSF.avi'));
    open(v)
    for i = 1:size(video,3)
        %Deblur
        img = imadjust(deconvreg(video(:,:,i), PSF,0.0001));
        %Denoising
        img = cv.bilateralFilter(uint8(img),'SigmaSpace',10,'SigmaColor',25,'Diameter',11);
        %Write frame in file
        writeVideo(v,img);
        clear img
    end
    close(v)
    
    %---------------------------------------------
    %   Bilateral + RL
    str = sprintf('Running Bilateral + RL...');
    disp(str);
    v = VideoWriter(strcat(pathResults,nameVideo,'-Bilateral_RL.avi'));
    open(v)
    for i = 1:size(video,3)
        %Deblur
        img = imadjust(deconvlucy(video(:,:,i), PSF));
        %Denoising
        img = cv.bilateralFilter(uint8(img),'SigmaSpace',10,'SigmaColor',25,'Diameter',11);
        %Write frame in file
        writeVideo(v,img);
        clear img
    end
    close(v)

    %---------------------------------------------
    %   NLM + Wiener
    Options.kernelratio = 3;Options.windowratio = 7;Options.nThreads=8;Options.filterstrength=0.1;

    str = sprintf('Running NLM + Wiener...');
    disp(str);
    v = VideoWriter(strcat(pathResults,nameVideo,'-NLM_Wiener.avi'));
    open(v)
    for i = 1:size(video,3)
        %Deblur
        img = im2double(imadjust(deconvwnr(video(:,:,i), PSF,0.0005)));
        %Denoising
        img = NLMF(img,Options);        
        %Write frame in file
        writeVideo(v,uint8(img*255));
        clear img
    end
    close(v)
    
    %---------------------------------------------
    %   NLM + CLSF
    str = sprintf('Running NLM + CLSF...');
    disp(str);
    v = VideoWriter(strcat(pathResults,nameVideo,'-NLM_CLSF.avi'));
    open(v)
    for i = 1:size(video,3)
        %Deblur
        img = im2double(imadjust(deconvreg(video(:,:,i), PSF,0.0001)));
        %Denoising
        img = NLMF(img,Options);         
        %Write frame in file
        writeVideo(v,uint8(img*255));
        clear img
    end
    close(v)
    
    %---------------------------------------------
    %   NLM + RL
    str = sprintf('Running NLM + RL...');
    disp(str);
    v = VideoWriter(strcat(pathResults,nameVideo,'-NLM_RL.avi'));
    open(v)
    for i = 1:size(video,3)
        %Deblur
        img = im2double(imadjust(deconvlucy(video(:,:,i), PSF)));
        %Denoising
        img = NLMF(img,Options); 
        %Write frame in file
        writeVideo(v,uint8(img*255));
        clear img
    end
    close(v)
    
    %---------------------------------------------
    %   BM3D + Wiener
    str = sprintf('Running BM3D + Wiener...');
    disp(str);
    v = VideoWriter(strcat(pathResults,nameVideo,'-BM3D_Wiener.avi'));
    open(v)
    for i = 1:size(video,3)
        %Deblur
        img = imadjust(deconvwnr(video(:,:,i), PSF,0.0005));
        %Denoising
        [NA img] = BM3D(1,img,41);       
        %Write frame in file
        writeVideo(v,img);
        clear img
    end
    close(v)
    
    %---------------------------------------------
    %   BM3D + CLSF
    str = sprintf('Running BM3D + CLSF...');
    disp(str);
    v = VideoWriter(strcat(pathResults,nameVideo,'-BM3D_CLSF.avi'));
    open(v)
    for i = 1:size(video,3)
        %Deblur
        img = imadjust(deconvreg(video(:,:,i), PSF,0.0001));
        %Denoising
        [NA img] = BM3D(1,img,41);         
        %Write frame in file
        writeVideo(v,img);
        clear img
    end
    close(v)
    
    %---------------------------------------------
    %   BM3D + RL
    str = sprintf('Running BM3D + RL...');
    disp(str);
    v = VideoWriter(strcat(pathResults,nameVideo,'-BM3D_RL.avi'));
    open(v)
    for i = 1:size(video,3)
        %Deblur
        img = imadjust(deconvlucy(video(:,:,i), PSF));
        %Denoising
        [NA img] = BM3D(1,img,41); 
        %Write frame in file
        writeVideo(v,img);
        clear img
    end
    close(v)
    
end