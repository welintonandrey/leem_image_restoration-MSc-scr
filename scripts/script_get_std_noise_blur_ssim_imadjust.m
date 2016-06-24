close all
clear all

addpath('./external algorithms/bilateral/Bilateral Filtering/');
addpath('./external algorithms/tv/');
addpath('./external algorithms/BM3D/');
addpath('./external algorithms/fast_nlmeans/');
addpath('./external algorithms/PSNR/');
addpath('./external algorithms/SSIM/');
addpath(genpath('external algorithms/mexopencv-master'));
% 
% %Read files
% str = sprintf('Reading files...');
% disp(str);
% 
% vMoviewGa = VideoReader('./videos/moview60fps.avi');
% vGaAsFringe = VideoReader('./videos/GaAsFringe.avi');
% vGrapheneIr = VideoReader('./videos/Graphene_ Ir.mov');
% vNiAl1 = VideoReader('./videos/NiAl01.avi');
% vNiAl2 = VideoReader('./videos/NiAl02.avi');
% vNiAl3 = VideoReader('./videos/NiAl03.avi');
% vNiAl4 = VideoReader('./videos/NiAl04.avi');
% vPbCu = VideoReader('./videos/Pb_Cu.avi');
% vBoronSi = VideoReader('./videos/Boron_Si.mov');
% vSi_001_10um_500ms_LEEMmode = VideoReader('./videos/20150919-leem-df-si(001)-3.94-10-3.37g-1.avi');
% vSi_100um_1000ms_PEEMmode = VideoReader('./videos/20150916-3.avi');
% 
% vSi_10um_1000ms_MEMmode = VideoReader('./videos/20150916-5.avi');
% vSi_MEMmode_10um_200ms = VideoReader('./videos/20150918-1.avi');
% 
% %Get uniform area
% str = sprintf('Get uniform area...');
% disp(str);
% 
% vMoviewGa.CurrentTime = 0;
% vecMoviewGa = [];
% while hasFrame(vMoviewGa)
%     img = rgb2gray(readFrame(vMoviewGa)); 
%     vec = im2double(imcrop(img,[100 100 10 10])); 
%     vecMoviewGa = horzcat(vecMoviewGa,vec(:));
% end
% 
% vGaAsFringe.CurrentTime = 0;
% vecGaAsFringe = [];
% while hasFrame(vGaAsFringe)
%     img = rgb2gray(readFrame(vGaAsFringe)); 
%     vec = im2double(imcrop(img,[420 234 10 10])); 
%     vecGaAsFringe = horzcat(vecGaAsFringe,vec(:));
% end
% 
% vGrapheneIr.CurrentTime = 0;
% vecGrapheneIr = [];
% while hasFrame(vGrapheneIr)
%     img = rgb2gray(readFrame(vGrapheneIr)); 
%     vec = im2double(imcrop(img,[83 125 10 10])); 
%     vecGrapheneIr = horzcat(vecGrapheneIr,vec(:));
% end
% 
% vNiAl1.CurrentTime = 0;
% vecNiAl1 = [];
% while hasFrame(vNiAl1)
%     img = rgb2gray(readFrame(vNiAl1)); 
%     vec = im2double(imcrop(img,[190 234 10 10])); 
%     vecNiAl1 = horzcat(vecNiAl1,vec(:));
% end
% 
% vNiAl2.CurrentTime = 0;
% vecNiAl2 = [];
% while hasFrame(vNiAl2)
%     img = rgb2gray(readFrame(vNiAl2)); 
%     vec = im2double(imcrop(img,[264 233 10 10])); 
%     vecNiAl2 = horzcat(vecNiAl2,vec(:));
% end
% 
% vNiAl3.CurrentTime = 0;
% vecNiAl3 = [];
% while hasFrame(vNiAl3)
%     img = rgb2gray(readFrame(vNiAl3)); 
%     vec = im2double(imcrop(img,[225 162 10 10])); 
%     vecNiAl3 = horzcat(vecNiAl3,vec(:));
% end
% 
% vNiAl4.CurrentTime = 0;
% vecNiAl4 = [];
% while hasFrame(vNiAl4)
%     img = rgb2gray(readFrame(vNiAl4)); 
%     vec = im2double(imcrop(img,[163 270 10 10])); 
%     vecNiAl4 = horzcat(vecNiAl4,vec(:));
% end
% 
% vPbCu.CurrentTime = 0;
% vecPbCu = [];
% while hasFrame(vPbCu)
%     img = rgb2gray(readFrame(vPbCu)); 
%     vec = im2double(imcrop(img,[72 151 20 20])); 
%     vecPbCu = horzcat(vecPbCu,vec(:));
%     
%     if vPbCu.CurrentTime > 5
%         break
%     end
%     
% end
% 
% vSi_001_10um_500ms_LEEMmode.CurrentTime = 0;
% vecSi_001_10um_500ms_LEEMmode = [];
% while hasFrame(vSi_001_10um_500ms_LEEMmode)
%     img = rgb2gray(readFrame(vSi_001_10um_500ms_LEEMmode)); 
%     vec = im2double(imcrop(img,[934 114 10 10])); 
%     vecSi_001_10um_500ms_LEEMmode = horzcat(vecSi_001_10um_500ms_LEEMmode,vec(:));
% end
% 
% vSi_100um_1000ms_PEEMmode.CurrentTime = 0;
% vecSi_100um_1000ms_PEEMmode = [];
% while hasFrame(vSi_100um_1000ms_PEEMmode)
%     img = rgb2gray(readFrame(vSi_100um_1000ms_PEEMmode)); 
%     vec = im2double(imcrop(img,[400 800 30 30])); 
%     vecSi_100um_1000ms_PEEMmode = horzcat(vecSi_100um_1000ms_PEEMmode,vec(:));
% end
% 
% vBoronSi.CurrentTime = 0;
% vecBoronSi = [];
% while hasFrame(vBoronSi)
%     img = rgb2gray(readFrame(vBoronSi)); 
%     vec = im2double(imcrop(img,[270 180 30 30])); 
%     vecBoronSi = horzcat(vecBoronSi,vec(:));
%     
%     if vPbCu.CurrentTime > 3
%         break
%     end
%     
% end
% 
% %Calc all variances
% str = sprintf('Calc all variances...');
% disp(str);
% varGaAsFringe = fitdist(vecGaAsFringe(:),'normal');
% varMoviewGa = fitdist(vecMoviewGa(:),'normal');
% varBoronSi = fitdist(vecBoronSi(:),'normal');
% varPbCu = fitdist(vecPbCu(:),'normal');
% varNiAl1 = fitdist(vecNiAl1(:),'normal');
% varNiAl2 = fitdist(vecNiAl2(:),'normal');
% varNiAl3 = fitdist(vecNiAl3(:),'normal');
% varNiAl4 = fitdist(vecNiAl4(:),'normal');
% varGrapheneIr = fitdist(vecGrapheneIr(:),'normal');
% varSi_001_10um_500ms_LEEMmode = fitdist(vecSi_001_10um_500ms_LEEMmode(:),'normal');
% varSi_100um_1000ms_PEEMmode = fitdist(vecSi_100um_1000ms_PEEMmode(:),'normal');
% 
% 
% 
% allVar = [varBoronSi.sigma, ... 
%     varGaAsFringe.sigma, ... 
%     varMoviewGa.sigma, ... 
%     varNiAl1.sigma, ... 
%     varNiAl2.sigma, ... 
%     varNiAl3.sigma, ... 
%     varNiAl4.sigma, ... 
%     varPbCu.sigma, ... 
%     varGrapheneIr.sigma, ...
%     varSi_001_10um_500ms_LEEMmode.sigma, ... 
%     varSi_100um_1000ms_PEEMmode.sigma];
% 
% str = sprintf('Sort variances...');
% disp(str);
% allVar = sort(allVar);
% 
% %---------------------------------------------------------------------------------------

allVar = [0.0176    0.0189    0.0189    0.0200    0.0256    0.0263    0.0286    0.0305    0.0340    0.0347    0.0523];

%Synthetic images
str = sprintf('Read synthetic images...');
disp(str);
S1 = phantom('Modified Shepp-Logan',500);
%S2 = checkerboard(50);
imgtest = S1;

%Read PSF
PSF = im2double(imread('psf.png'));
PSF = PSF ./ sum(PSF(:));

%Add Noise and Blur
str = sprintf('Add Noise and Blur in synthetic images...');
disp(str);
for v = 1:length(allVar)
    res(v).image = imnoise(mat2gray(imgtest),'gaussian',0,allVar(v)/10);
    res(v).image = mat2gray(imfilter(res(v).image, PSF));
    res(v).psnr = PSNR(imgtest,res(1,v).image);
    res(v).ssim = ssim(uint8(255*imgtest),uint8(255*res(1,v).image));
    res(v).sigma = allVar(v);
    %figure;imshow(res(1,v).image),title(sprintf('S1 %f',allVar(v)));
end

%---------------------------------------------------------------------------------------
%Running Deblur
str = sprintf('Running deblur...');
disp(str);
for v = 1:length(allVar)
%     res(v).debluredwnr = mat2gray(deconvwnr(res(v).image, PSF,0.0005));
%     res(v).debluredclsf = mat2gray(deconvreg(res(v).image, PSF,0.0001));
%     res(v).debluredlucy = mat2gray(deconvlucy(res(v).image, PSF));
    res(v).debluredwnr = imadjust(deconvwnr(res(v).image, PSF,0.0005));
    res(v).debluredclsf = imadjust(deconvreg(res(v).image, PSF,0.0001));
    res(v).debluredlucy = imadjust(deconvlucy(res(v).image, PSF));
end

%---------------------------------------------------------------------------------------
%Running denoising methods

%---------------------------------------------
%   TV + Wiener
str = sprintf('Running TV + Wiener...');
disp(str);
for v = 1:length(allVar)
    s = [];
    for i=0.1:0.1:2.0
        out = cv.denoise_TVL1(uint8(255*res(v).debluredwnr),'Lambda',i);
        out = imadjust(out);
        saida.param = i;
        saida.psnr = PSNR(imgtest,im2double(out));
        saida.ssim = ssim(uint8(255*imgtest),out);
        saida.image = out;
        s = horzcat(s,saida);
    end
    res(v).tv_wnr_imgs = s;
    [values,index] = sort([s.ssim],'descend');
    res(v).tv_wnr_bestresult = values(1);
    res(v).tv_wnr_bestparam = s(index(1)).param;
end

%---------------------------------------------
%   TV + CLSF
str = sprintf('Running TV + CLSF...');
disp(str);
for v = 1:length(allVar)
    s = [];
    for i=0.1:0.1:2.0
        out = cv.denoise_TVL1(uint8(255*res(v).debluredclsf),'Lambda',i);
        out = imadjust(out);
        saida.param = i;
        saida.psnr = PSNR(imgtest,im2double(out));
        saida.ssim = ssim(uint8(255*imgtest),out);
        saida.image = out;
        s = horzcat(s,saida);
    end
    res(v).tv_clsf_imgs = s;
    [values,index] = sort([s.ssim],'descend');
    res(v).tv_clsf_bestresult = values(1);
    res(v).tv_clsf_bestparam = s(index(1)).param;
end

%---------------------------------------------
%   TV + RL
str = sprintf('Running TV + RL...');
disp(str);
for v = 1:length(allVar)
    s = [];
    for i=0.1:0.1:2.0
        out = cv.denoise_TVL1(uint8(255*res(v).debluredlucy),'Lambda',i);
        out = imadjust(out);
        saida.param = i;
        saida.psnr = PSNR(imgtest,im2double(out));
        saida.ssim = ssim(uint8(255*imgtest),out);
        saida.image = out;
        s = horzcat(s,saida);
    end
    res(v).tv_rl_imgs = s;
    [values,index] = sort([s.ssim],'descend');
    res(v).tv_rl_bestresult = values(1);
    res(v).tv_rl_bestparam = s(index(1)).param;
end

%---------------------------------------------
%   BF + Wiener
str = sprintf('Running Bilateral + Wiener...');
disp(str);
for v = 1:length(allVar)
    s = [];
    for i=10:1:60
        out = cv.bilateralFilter(uint8(res(v).debluredwnr*255),'SigmaSpace',10,'SigmaColor',i,'Diameter',11);
        out = imadjust(out);
        saida.param = i;
        saida.psnr = PSNR(mat2gray(imgtest),im2double(out));
        saida.ssim = ssim(uint8(255*mat2gray(imgtest)),out);
        saida.image = out;
        s = horzcat(s,saida);
    end
    res(v).bl_wnr_imgs = s;
    [values,index] = sort([s.ssim],'descend');
    res(v).bl_wnr_bestresult = values(1);
    res(v).bl_wnr_bestparam = s(index(1)).param;
end

%---------------------------------------------
%   BF + CLSF
str = sprintf('Running Bilateral + CLSF...');
disp(str);
for v = 1:length(allVar)
    s = [];
    for i=10:1:60
        out = cv.bilateralFilter(uint8(res(v).debluredclsf*255),'SigmaSpace',10,'SigmaColor',i,'Diameter',11);
        out = imadjust(out);
        saida.param = i;
        saida.psnr = PSNR(mat2gray(imgtest),im2double(out));
        saida.ssim = ssim(uint8(255*mat2gray(imgtest)),out);
        saida.image = out;
        s = horzcat(s,saida);
    end
    res(v).bl_clsf_imgs = s;
    [values,index] = sort([s.ssim],'descend');
    res(v).bl_clsf_bestresult = values(1);
    res(v).bl_clsf_bestparam = s(index(1)).param;
end

%---------------------------------------------
%   BF + RL
str = sprintf('Running Bilateral + RL...');
disp(str);
for v = 1:length(allVar)
    s = [];
    for i=10:1:60
        out = cv.bilateralFilter(uint8(res(v).debluredlucy*255),'SigmaSpace',10,'SigmaColor',i,'Diameter',11);
        out = imadjust(out);
        saida.param = i;
        saida.psnr = PSNR(mat2gray(imgtest),im2double(out));
        saida.ssim = ssim(uint8(255*mat2gray(imgtest)),out);
        saida.image = out;
        s = horzcat(s,saida);
    end
    res(v).bl_rl_imgs = s;
    [values,index] = sort([s.ssim],'descend');
    res(v).bl_rl_bestresult = values(1);
    res(v).bl_rl_bestparam = s(index(1)).param;
end

% str = sprintf('Loading Results Adaptive Bilateral (OpenCV 2.4.11)...');
% disp(str);
% for v = 1:11
%     s = [];
%     for i=1:1:50
%         str = strcat('external algorithms/ABFOpenCV/',num2str(v),'/sigma', num2str(i), '.png');
%         out = imread(str);
%         saida.param = i;
%         saida.psnr = PSNR(mat2gray(imgtest),im2double(out));
%         saida.ssim = ssim(uint8(255*mat2gray(imgtest)),out);
%         saida.image = out;
%         s = horzcat(s,saida);
%     end
%     res(v).adpblimgs = s;
%     [values,index] = sort([s.psnr],'descend');
%     res(v).adpblbestresult = values(1);
%     res(v).adpblbestparam = s(index(1)).param;
%     
%     %[values,index] = sort([s.psnr],'descend');
%     %res(v).adpblbestresultPSNR = values(1);
%     %res(v).adpblbestparamPSNR = s(index(1)).param;
%     %[values,index] = sort([s.ssim],'descend');
%     %res(v).adpblbestresultSSIM = values(1);
%     %res(v).adpblbestparamSSIM = s(index(1)).param;
% end

%---------------------------------------------
%   NLM + Wiener
str = sprintf('Running NLM + Wiener...');
disp(str);
for v = 1:length(allVar)
    s = [];
    for i=0.01:0.01:0.1
        Options.kernelratio = 3;Options.windowratio = 7;Options.nThreads=8;Options.filterstrength=i;
        out = NLMF(res(v).debluredwnr,Options);
        out = imadjust(out);
        %out = cv.fastNlMeansDenoising(uint8(255*res(v).image),'H',i,'TemplateWindowSize',9,'SearchWindowSize',25);
        saida.param = i;
        saida.psnr = PSNR(imgtest,out);
        saida.ssim = ssim(uint8(255*imgtest),uint8(255*out));
        saida.image = out;
        s = horzcat(s,saida);
    end
    res(v).nlm_wnr_imgs = s;
    [values,index] = sort([s.ssim],'descend');
    res(v).nlm_wnr_bestresult = values(1);
    res(v).nlm_wnr_bestparam = s(index(1)).param;
end

%---------------------------------------------
%   NLM + CLSF
str = sprintf('Running NLM + CLSF...');
disp(str);
for v = 1:length(allVar)
    s = [];
    for i=0.01:0.01:0.1
        Options.kernelratio = 3;Options.windowratio = 7;Options.nThreads=8;Options.filterstrength=i;
        out = NLMF(res(v).debluredclsf,Options);
        out = imadjust(out);
        %out = cv.fastNlMeansDenoising(uint8(255*res(v).image),'H',i,'TemplateWindowSize',9,'SearchWindowSize',25);
        saida.param = i;
        saida.psnr = PSNR(imgtest,out);
        saida.ssim = ssim(uint8(255*imgtest),uint8(255*out));
        saida.image = out;
        s = horzcat(s,saida);
    end
    res(v).nlm_clsf_imgs = s;
    [values,index] = sort([s.ssim],'descend');
    res(v).nlm_clsf_bestresult = values(1);
    res(v).nlm_clsf_bestparam = s(index(1)).param;
end

%---------------------------------------------
%   NLM + RL
str = sprintf('Running NLM + RL...');
disp(str);
for v = 1:length(allVar)
    s = [];
    for i=0.01:0.01:0.1
        Options.kernelratio = 3;Options.windowratio = 7;Options.nThreads=8;Options.filterstrength=i;
        out = NLMF(res(v).debluredlucy,Options);
        out = imadjust(out);
        %out = cv.fastNlMeansDenoising(uint8(255*res(v).image),'H',i,'TemplateWindowSize',9,'SearchWindowSize',25);
        saida.param = i;
        saida.psnr = PSNR(imgtest,out);
        saida.ssim = ssim(uint8(255*imgtest),uint8(255*out));
        saida.image = out;
        s = horzcat(s,saida);
    end
    res(v).nlm_rl_imgs = s;
    [values,index] = sort([s.ssim],'descend');
    res(v).nlm_rl_bestresult = values(1);
    res(v).nlm_rl_bestparam = s(index(1)).param;
end

%---------------------------------------------
%   BM3D + Wiener
str = sprintf('Running BM3D + Wiener...');
disp(str);
for v = 1:length(allVar)
    s = [];
    for i=10:50
        [NA out] = BM3D(1,res(v).debluredwnr,i);
        out = imadjust(out);
        saida.param = i;
        saida.psnr = PSNR(imgtest,out);
        saida.ssim = ssim(uint8(255*imgtest),uint8(255*out));
        saida.image = out;
        s = horzcat(s,saida);
    end
    res(v).bm3d_wnr_imgs = s;
    [values,index] = sort([s.ssim],'descend');
    res(v).bm3d_wnr_bestresult = values(1);
    res(v).bm3d_wnr_bestparam = s(index(1)).param;
end

%---------------------------------------------
%   BM3D + CLSF
str = sprintf('Running BM3D + CLSF...');
disp(str);
for v = 1:length(allVar)
    s = [];
    for i=10:50
        [NA out] = BM3D(1,res(v).debluredclsf,i);
        out = imadjust(out);
        saida.param = i;
        saida.psnr = PSNR(imgtest,out);
        saida.ssim = ssim(uint8(255*imgtest),uint8(255*out));
        saida.image = out;
        s = horzcat(s,saida);
    end
    res(v).bm3d_clsf_imgs = s;
    [values,index] = sort([s.ssim],'descend');
    res(v).bm3d_clsf_bestresult = values(1);
    res(v).bm3d_clsf_bestparam = s(index(1)).param;
end

%---------------------------------------------
%   BM3D + RL
str = sprintf('Running BM3D + RL...');
disp(str);
for v = 1:length(allVar)
    s = [];
    for i=10:50
        [NA out] = BM3D(1,res(v).debluredlucy,i);
        out = imadjust(out);
        saida.param = i;
        saida.psnr = PSNR(imgtest,out);
        saida.ssim = ssim(uint8(255*imgtest),uint8(255*out));
        saida.image = out;
        s = horzcat(s,saida);
    end
    res(v).bm3d_rl_imgs = s;
    [values,index] = sort([s.ssim],'descend');
    res(v).bm3d_rl_bestresult = values(1);
    res(v).bm3d_rl_bestparam = s(index(1)).param;
end
% 
% 
% 
% save('work-blur-ssim-imadjust3.mat','res','-v7.3');
