
PSF = im2double(imread('psf.png'));
PSF = PSF ./ sum(PSF(:));

% apllyDeconvolutionsInFrames(PSF,'/home/welinton/Desktop/AnaliseVideosLEEM/videos/frames/gaas/',50);
apllyDeconvolutionsInFrames(PSF,'/home/welinton/Desktop/AnaliseVideosLEEM/videos/frames/boron/',50);
apllyDeconvolutionsInFrames(PSF,'/home/welinton/Desktop/AnaliseVideosLEEM/videos/frames/moview/',50);
apllyDeconvolutionsInFrames(PSF,'/home/welinton/Desktop/AnaliseVideosLEEM/videos/frames/neelz/',50);
apllyDeconvolutionsInFrames(PSF,'/home/welinton/Desktop/AnaliseVideosLEEM/videos/frames/nial1/',50);
apllyDeconvolutionsInFrames(PSF,'/home/welinton/Desktop/AnaliseVideosLEEM/videos/frames/nial2/',50);
apllyDeconvolutionsInFrames(PSF,'/home/welinton/Desktop/AnaliseVideosLEEM/videos/frames/nial3/',50);
apllyDeconvolutionsInFrames(PSF,'/home/welinton/Desktop/AnaliseVideosLEEM/videos/frames/nial4/',50);
apllyDeconvolutionsInFrames(PSF,'/home/welinton/Desktop/AnaliseVideosLEEM/videos/frames/graphene/',50);
apllyDeconvolutionsInFrames(PSF,'/home/welinton/Desktop/AnaliseVideosLEEM/videos/frames/pbcu/',50);



