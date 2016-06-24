function readSPLEEMFiles(path,initNameFile,numberTotalFrames,typeImage)

    pathVideo = strcat(path,initNameFile,'Video.avi');
    videoW = VideoWriter(pathVideo);
    open(videoW);

    for frame=1:numberTotalFrames
        str = strcat(path,initNameFile,sprintf('%05d',frame),typeImage);
        
        im = imread(str);
        im = mat2gray(im);
        %whos im;
        
        writeVideo(videoW,im);
        %imshow(im);
        %pause();
        str = strcat('Writing frame: ',initNameFile,sprintf('%05d',frame),typeImage);
        disp(str);
    end
    
    close(videoW);

end