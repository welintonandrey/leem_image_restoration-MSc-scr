function filterFrame(path,imgName,deblurName)

    img = imread(strcat(path,'noise.png'));
    img1 = imread(strcat(path,'NLM3D-LBP-Adaptive.png'));
    img2 = imread(strcat(path,'NLM3D-LBP-MSB.png'));

    denoisedTV = cv.denoise_TVL1(img,'Lambda',1.2);
    denoisedBL = cv.bilateralFilter(img,'SigmaSpace',10,'SigmaColor',25,'Diameter',11);

    Options.kernelratio = 3;Options.windowratio = 7;Options.nThreads=8;Options.filterstrength=0.1;
    denoisedNLM = NLMF(im2double(img),Options);        

    [NA denoisedBM3D] = BM3D(1,img,40); 
    
    imwrite(denoisedTV,strcat(path,'/',imgName,deblurName,'TV.png'));
    imwrite(denoisedBL,strcat(path,'/',imgName,deblurName,'BF.png'));
    imwrite(denoisedNLM,strcat(path,'/',imgName,deblurName,'NLM.png'));
    imwrite(denoisedBM3D,strcat(path,'/',imgName,deblurName,'BM3D.png'));
    imwrite(img1,strcat(path,'/',imgName,deblurName,'NLM3D-LBP-Adaptive.png'));
    imwrite(img2,strcat(path,'/',imgName,deblurName,'NLM3D-LBP-MSB.png'));
    
end