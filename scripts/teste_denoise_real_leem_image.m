%------------------------------------------------------------------
%Add Paths
%------------------------------------------------------------------
addpath('./external algorithms/BM3D/');
addpath('./external algorithms/fast_nlmeans/');
addpath('./external algorithms/PSNR/');
addpath('./external algorithms/SSIM/');
addpath(genpath('external algorithms/mexopencv-master'));

%------------------------------------------------------------------
%Read Frames
%------------------------------------------------------------------

i100ms = imread('frames/100ms.bmp');
boron = imread('frames/BoronSi.png');
gaas = imread('frames/GaAsFringe.png');
graph = imread('frames/GrapheneIr.png');
moview = imread('frames/MoviewGa.png');
nial1 = imread('frames/NiAl1.png');
nial2 = imread('frames/NiAl2.png');
nial3 = imread('frames/NiAl3.png');
nial4 = imread('frames/NiAl4.png');
pbcu = imread('frames/PbCu.png');
si001 = imread('frames/Si_001_10um_500ms_LEEMmode.png');
si10 = imread('frames/Si_10um_1000ms_MEMmode.png');
si100 = imread('frames/Si_100um_100ms_PEEMmode.png');
simem = imread('frames/Si_MEMmode_10um_200ms.png');
bloch_z = imread('frames/bloch_z.png');
neel_z = imread('frames/neel_z.png');

%------------------------------------------------------------------
%Read PSF
%------------------------------------------------------------------

PSF = im2double(imread('psf.png'));
PSF = PSF ./ sum(PSF(:));


%------------------------------------------------------------------
%Run Deconvolution
%------------------------------------------------------------------
i100msWnr = imadjust(deconvwnr(i100ms, PSF,0.0005));
i100msCLSF = imadjust(deconvreg(i100ms, PSF,0.0001));
i100msRL = imadjust(deconvlucy(i100ms, PSF));

boronWnr = imadjust(deconvwnr(boron, PSF,0.0005));
boronCLSF = imadjust(deconvreg(boron, PSF,0.0001));
boronRL = imadjust(deconvlucy(boron, PSF));

gaasWnr = imadjust(deconvwnr(gaas, PSF,0.0005));
gaasCLSF = imadjust(deconvreg(gaas, PSF,0.0001));
gaasRL = imadjust(deconvlucy(gaas, PSF));

graphWnr = imadjust(deconvwnr(graph, PSF,0.0005));
graphCLSF = imadjust(deconvreg(graph, PSF,0.0001));
graphRL = imadjust(deconvlucy(graph, PSF));

moviewWnr = imadjust(deconvwnr(moview, PSF,0.0005));
moviewCLSF = imadjust(deconvreg(moview, PSF,0.0001));
moviewRL = imadjust(deconvlucy(moview, PSF));

nial1Wnr = imadjust(deconvwnr(nial1, PSF,0.0005));
nial1CLSF = imadjust(deconvreg(nial1, PSF,0.0001));
nial1RL = imadjust(deconvlucy(nial1, PSF));

nial2Wnr = imadjust(deconvwnr(nial2, PSF,0.0005));
nial2CLSF = imadjust(deconvreg(nial2, PSF,0.0001));
nial2RL = imadjust(deconvlucy(nial2, PSF));

nial3Wnr = imadjust(deconvwnr(nial3, PSF,0.0005));
nial3CLSF = imadjust(deconvreg(nial3, PSF,0.0001));
nial3RL = imadjust(deconvlucy(nial3, PSF));

nial4Wnr = imadjust(deconvwnr(nial4, PSF,0.0005));
nial4CLSF = imadjust(deconvreg(nial4, PSF,0.0001));
nial4RL = imadjust(deconvlucy(nial4, PSF));

pbcuWnr = imadjust(deconvwnr(pbcu, PSF,0.0005));
pbcuCLSF = imadjust(deconvreg(pbcu, PSF,0.0001));
pbcuRL = imadjust(deconvlucy(pbcu, PSF));

si001Wnr = imadjust(deconvwnr(si001, PSF,0.0005));
si001CLSF = imadjust(deconvreg(si001, PSF,0.0001));
si001RL = imadjust(deconvlucy(si001, PSF));

si10Wnr = imadjust(deconvwnr(si10, PSF,0.0005));
si10CLSF = imadjust(deconvreg(si10, PSF,0.0001));
si10RL = imadjust(deconvlucy(si10, PSF));

si100Wnr = imadjust(deconvwnr(si100, PSF,0.0005));
si100CLSF = imadjust(deconvreg(si100, PSF,0.0001));
si100RL = imadjust(deconvlucy(si100, PSF));

simemWnr = imadjust(deconvwnr(simem, PSF,0.0005));
simemCLSF = imadjust(deconvreg(simem, PSF,0.0001));
simemRL = imadjust(deconvlucy(simem, PSF));

bloch_zWnr = imadjust(deconvwnr(bloch_z, PSF,0.0005));
bloch_zCLSF = imadjust(deconvreg(bloch_z, PSF,0.0001));
bloch_zRL = imadjust(deconvlucy(bloch_z, PSF));

neel_zWnr = imadjust(deconvwnr(neel_z, PSF,0.0005));
neel_zCLSF = imadjust(deconvreg(neel_z, PSF,0.0001));
neel_zRL = imadjust(deconvlucy(neel_z, PSF));

%------------------------------------------------------------------
%Show Deconvolution
%------------------------------------------------------------------
% imshow(i100ms);
% figure;imshow(i100msWnr);
% figure;imshow(i100msCLSF);
% figure;imshow(i100msRL)

% subplot(221);imshow(i100ms);
% title('Original Image');
% subplot(222);imshow(i100msWnr);
% title('Deconv Wiener');
% subplot(223);imshow(i100msCLSF);
% title('Deconv CLSF');
% subplot(224);imshow(i100msRL);
% title('Deconv RL)');

%------------------------------------------------------------------
%Run Denoise
%------------------------------------------------------------------
Options.kernelratio = 3;Options.windowratio = 7;Options.nThreads=8;Options.filterstrength=0.1;


i100msWnrTV = imadjust(cv.denoise_TVL1(i100msWnr,'Lambda',0.92));
i100msWnrBF = imadjust(cv.bilateralFilter(i100msWnr,'SigmaSpace',10,'SigmaColor',22,'Diameter',11));
i100msWnrNLM = NLMF(im2double(i100msWnr),Options);
[NA i100msWnrBM3D] = BM3D(1,i100msWnr,49);

i100msCLSFTV = imadjust(cv.denoise_TVL1(i100msCLSF,'Lambda',0.92));
i100msCLSFBF = imadjust(cv.bilateralFilter(i100msCLSF,'SigmaSpace',10,'SigmaColor',22,'Diameter',11));
i100msCLSFNLM = NLMF(im2double(i100msCLSF),Options);
[NA i100msCLSFBM3D] = BM3D(1,i100msCLSF,49);

i100msRLTV = imadjust(cv.denoise_TVL1(i100msRL,'Lambda',0.92));
i100msRLBF = imadjust(cv.bilateralFilter(i100msRL,'SigmaSpace',10,'SigmaColor',22,'Diameter',11));
i100msRLNLM = NLMF(im2double(i100msRL),Options);
[NA i100msRLBM3D] = BM3D(1,i100msRL,49);

boronWnrTV = imadjust(cv.denoise_TVL1(boronWnr,'Lambda',0.92));
boronWnrBF = imadjust(cv.bilateralFilter(boronWnr,'SigmaSpace',10,'SigmaColor',22,'Diameter',11));
boronWnrNLM = NLMF(im2double(boronWnr),Options);
[NA boronWnrBM3D] = BM3D(1,boronWnr,49);

boronCLSFTV = imadjust(cv.denoise_TVL1(boronCLSF,'Lambda',0.92));
boronCLSFBF = imadjust(cv.bilateralFilter(boronCLSF,'SigmaSpace',10,'SigmaColor',22,'Diameter',11));
boronCLSFNLM = NLMF(im2double(boronCLSF),Options);
[NA boronCLSFBM3D] = BM3D(1,boronCLSF,49);

boronRLTV = imadjust(cv.denoise_TVL1(boronRL,'Lambda',0.92));
boronRLBF = imadjust(cv.bilateralFilter(boronRL,'SigmaSpace',10,'SigmaColor',22,'Diameter',11));
boronRLNLM = NLMF(im2double(boronRL),Options);
[NA boronRLBM3D] = BM3D(1,boronRL,49);

gaasWnrTV = imadjust(cv.denoise_TVL1(gaasWnr,'Lambda',0.92));
gaasWnrBF = imadjust(cv.bilateralFilter(gaasWnr,'SigmaSpace',10,'SigmaColor',22,'Diameter',11));
gaasWnrNLM = NLMF(im2double(gaasWnr),Options);
[NA gaasWnrBM3D] = BM3D(1,gaasWnr,49);

gaasCLSFTV = imadjust(cv.denoise_TVL1(gaasCLSF,'Lambda',0.92));
gaasCLSFBF = imadjust(cv.bilateralFilter(gaasCLSF,'SigmaSpace',10,'SigmaColor',22,'Diameter',11));
gaasCLSFNLM = NLMF(im2double(gaasCLSF),Options);
[NA gaasCLSFBM3D] = BM3D(1,gaasCLSF,49);

gaasRLTV = imadjust(cv.denoise_TVL1(gaasRL,'Lambda',0.92));
gaasRLBF = imadjust(cv.bilateralFilter(gaasRL,'SigmaSpace',10,'SigmaColor',22,'Diameter',11));
gaasRLNLM = NLMF(im2double(gaasRL),Options);
[NA gaasRLBM3D] = BM3D(1,gaasRL,49);

graphWnrTV = imadjust(cv.denoise_TVL1(graphWnr,'Lambda',0.92));
graphWnrBF = imadjust(cv.bilateralFilter(graphWnr,'SigmaSpace',10,'SigmaColor',22,'Diameter',11));
graphWnrNLM = NLMF(im2double(graphWnr),Options);
[NA graphWnrBM3D] = BM3D(1,graphWnr,49);

graphCLSFTV = imadjust(cv.denoise_TVL1(graphCLSF,'Lambda',0.92));
graphCLSFBF = imadjust(cv.bilateralFilter(graphCLSF,'SigmaSpace',10,'SigmaColor',22,'Diameter',11));
graphCLSFNLM = NLMF(im2double(graphCLSF),Options);
[NA graphCLSFBM3D] = BM3D(1,graphCLSF,49);

graphRLTV = imadjust(cv.denoise_TVL1(graphRL,'Lambda',0.92));
graphRLBF = imadjust(cv.bilateralFilter(graphRL,'SigmaSpace',10,'SigmaColor',22,'Diameter',11));
graphRLNLM = NLMF(im2double(graphRL),Options);
[NA graphRLBM3D] = BM3D(1,graphRL,49);

moviewWnrTV = imadjust(cv.denoise_TVL1(moviewWnr,'Lambda',0.92));
moviewWnrBF = imadjust(cv.bilateralFilter(moviewWnr,'SigmaSpace',10,'SigmaColor',22,'Diameter',11));
moviewWnrNLM = NLMF(im2double(moviewWnr),Options);
[NA moviewWnrBM3D] = BM3D(1,moviewWnr,49);

moviewCLSFTV = imadjust(cv.denoise_TVL1(moviewCLSF,'Lambda',0.92));
moviewCLSFBF = imadjust(cv.bilateralFilter(moviewCLSF,'SigmaSpace',10,'SigmaColor',22,'Diameter',11));
moviewCLSFNLM = NLMF(im2double(moviewCLSF),Options);
[NA moviewCLSFBM3D] = BM3D(1,moviewCLSF,49);

moviewRLTV = imadjust(cv.denoise_TVL1(moviewRL,'Lambda',0.92));
moviewRLBF = imadjust(cv.bilateralFilter(moviewRL,'SigmaSpace',10,'SigmaColor',22,'Diameter',11));
moviewRLNLM = NLMF(im2double(moviewRL),Options);
[NA moviewRLBM3D] = BM3D(1,moviewRL,49);

nial1WnrTV = imadjust(cv.denoise_TVL1(nial1Wnr,'Lambda',0.92));
nial1WnrBF = imadjust(cv.bilateralFilter(nial1Wnr,'SigmaSpace',10,'SigmaColor',22,'Diameter',11));
nial1WnrNLM = NLMF(im2double(nial1Wnr),Options);
[NA nial1WnrBM3D] = BM3D(1,nial1Wnr,49);

nial1CLSFTV = imadjust(cv.denoise_TVL1(nial1CLSF,'Lambda',0.92));
nial1CLSFBF = imadjust(cv.bilateralFilter(nial1CLSF,'SigmaSpace',10,'SigmaColor',22,'Diameter',11));
nial1CLSFNLM = NLMF(im2double(nial1CLSF),Options);
[NA nial1CLSFBM3D] = BM3D(1,nial1CLSF,49);

nial1RLTV = imadjust(cv.denoise_TVL1(nial1RL,'Lambda',0.92));
nial1RLBF = imadjust(cv.bilateralFilter(nial1RL,'SigmaSpace',10,'SigmaColor',22,'Diameter',11));
nial1RLNLM = NLMF(im2double(nial1RL),Options);
[NA nial1RLBM3D] = BM3D(1,nial1RL,49);

nial2WnrTV = imadjust(cv.denoise_TVL1(nial2Wnr,'Lambda',0.92));
nial2WnrBF = imadjust(cv.bilateralFilter(nial2Wnr,'SigmaSpace',10,'SigmaColor',22,'Diameter',11));
nial2WnrNLM = NLMF(im2double(nial2Wnr),Options);
[NA nial2WnrBM3D] = BM3D(1,nial2Wnr,49);

nial2CLSFTV = imadjust(cv.denoise_TVL1(nial2CLSF,'Lambda',0.92));
nial2CLSFBF = imadjust(cv.bilateralFilter(nial2CLSF,'SigmaSpace',10,'SigmaColor',22,'Diameter',11));
nial2CLSFNLM = NLMF(im2double(nial2CLSF),Options);
[NA nial2CLSFBM3D] = BM3D(1,nial2CLSF,49);

nial2RLTV = imadjust(cv.denoise_TVL1(nial2RL,'Lambda',0.92));
nial2RLBF = imadjust(cv.bilateralFilter(nial2RL,'SigmaSpace',10,'SigmaColor',22,'Diameter',11));
nial2RLNLM = NLMF(im2double(nial2RL),Options);
[NA nial2RLBM3D] = BM3D(1,nial2RL,49);

nial3WnrTV = imadjust(cv.denoise_TVL1(nial3Wnr,'Lambda',0.92));
nial3WnrBF = imadjust(cv.bilateralFilter(nial3Wnr,'SigmaSpace',10,'SigmaColor',22,'Diameter',11));
nial3WnrNLM = NLMF(im2double(nial3Wnr),Options);
[NA nial3WnrBM3D] = BM3D(1,nial3Wnr,49);

nial3CLSFTV = imadjust(cv.denoise_TVL1(nial3CLSF,'Lambda',0.92));
nial3CLSFBF = imadjust(cv.bilateralFilter(nial3CLSF,'SigmaSpace',10,'SigmaColor',22,'Diameter',11));
nial3CLSFNLM = NLMF(im2double(nial3CLSF),Options);
[NA nial3CLSFBM3D] = BM3D(1,nial3CLSF,49);

nial3RLTV = imadjust(cv.denoise_TVL1(nial3RL,'Lambda',0.92));
nial3RLBF = imadjust(cv.bilateralFilter(nial3RL,'SigmaSpace',10,'SigmaColor',22,'Diameter',11));
nial3RLNLM = NLMF(im2double(nial3RL),Options);
[NA nial3RLBM3D] = BM3D(1,nial3RL,49);

nial4WnrTV = imadjust(cv.denoise_TVL1(nial4Wnr,'Lambda',0.92));
nial4WnrBF = imadjust(cv.bilateralFilter(nial4Wnr,'SigmaSpace',10,'SigmaColor',22,'Diameter',11));
nial4WnrNLM = NLMF(im2double(nial4Wnr),Options);
[NA nial4WnrBM3D] = BM3D(1,nial4Wnr,49);

nial4CLSFTV = imadjust(cv.denoise_TVL1(nial4CLSF,'Lambda',0.92));
nial4CLSFBF = imadjust(cv.bilateralFilter(nial4CLSF,'SigmaSpace',10,'SigmaColor',22,'Diameter',11));
nial4CLSFNLM = NLMF(im2double(nial4CLSF),Options);
[NA nial4CLSFBM3D] = BM3D(1,nial4CLSF,49);

nial4RLTV = imadjust(cv.denoise_TVL1(nial4RL,'Lambda',0.92));
nial4RLBF = imadjust(cv.bilateralFilter(nial4RL,'SigmaSpace',10,'SigmaColor',22,'Diameter',11));
nial4RLNLM = NLMF(im2double(nial4RL),Options);
[NA nial4RLBM3D] = BM3D(1,nial4RL,49);

pbcuWnrTV = imadjust(cv.denoise_TVL1(pbcuWnr,'Lambda',0.92));
pbcuWnrBF = imadjust(cv.bilateralFilter(pbcuWnr,'SigmaSpace',10,'SigmaColor',22,'Diameter',11));
pbcuWnrNLM = NLMF(im2double(pbcuWnr),Options);
[NA pbcuWnrBM3D] = BM3D(1,pbcuWnr,49);

pbcuCLSFTV = imadjust(cv.denoise_TVL1(pbcuCLSF,'Lambda',0.92));
pbcuCLSFBF = imadjust(cv.bilateralFilter(pbcuCLSF,'SigmaSpace',10,'SigmaColor',22,'Diameter',11));
pbcuCLSFNLM = NLMF(im2double(pbcuCLSF),Options);
[NA pbcuCLSFBM3D] = BM3D(1,pbcuCLSF,49);

pbcuRLTV = imadjust(cv.denoise_TVL1(pbcuRL,'Lambda',0.92));
pbcuRLBF = imadjust(cv.bilateralFilter(pbcuRL,'SigmaSpace',10,'SigmaColor',22,'Diameter',11));
pbcuRLNLM = NLMF(im2double(pbcuRL),Options);
[NA pbcuRLBM3D] = BM3D(1,pbcuRL,49);

si001WnrTV = imadjust(cv.denoise_TVL1(si001Wnr,'Lambda',0.92));
si001WnrBF = imadjust(cv.bilateralFilter(si001Wnr,'SigmaSpace',10,'SigmaColor',22,'Diameter',11));
si001WnrNLM = NLMF(im2double(si001Wnr),Options);
[NA si001WnrBM3D] = BM3D(1,si001Wnr,49);

si001CLSFTV = imadjust(cv.denoise_TVL1(si001CLSF,'Lambda',0.92));
si001CLSFBF = imadjust(cv.bilateralFilter(si001CLSF,'SigmaSpace',10,'SigmaColor',22,'Diameter',11));
si001CLSFNLM = NLMF(im2double(si001CLSF),Options);
[NA si001CLSFBM3D] = BM3D(1,si001CLSF,49);

si001RLTV = imadjust(cv.denoise_TVL1(si001RL,'Lambda',0.92));
si001RLBF = imadjust(cv.bilateralFilter(si001RL,'SigmaSpace',10,'SigmaColor',22,'Diameter',11));
si001RLNLM = NLMF(im2double(si001RL),Options);
[NA si001RLBM3D] = BM3D(1,si001RL,49);

si10WnrTV = imadjust(cv.denoise_TVL1(si10Wnr,'Lambda',0.92));
si10WnrBF = imadjust(cv.bilateralFilter(si10Wnr,'SigmaSpace',10,'SigmaColor',22,'Diameter',11));
si10WnrNLM = NLMF(im2double(si10Wnr),Options);
[NA si10WnrBM3D] = BM3D(1,si10Wnr,49);

si10CLSFTV = imadjust(cv.denoise_TVL1(si10CLSF,'Lambda',0.92));
si10CLSFBF = imadjust(cv.bilateralFilter(si10CLSF,'SigmaSpace',10,'SigmaColor',22,'Diameter',11));
si10CLSFNLM = NLMF(im2double(si10CLSF),Options);
[NA si10CLSFBM3D] = BM3D(1,si10CLSF,49);

si10RLTV = imadjust(cv.denoise_TVL1(si10RL,'Lambda',0.92));
si10RLBF = imadjust(cv.bilateralFilter(si10RL,'SigmaSpace',10,'SigmaColor',22,'Diameter',11));
si10RLNLM = NLMF(im2double(si10RL),Options);
[NA si10RLBM3D] = BM3D(1,si10RL,49);

si100WnrTV = imadjust(cv.denoise_TVL1(si100Wnr,'Lambda',0.92));
si100WnrBF = imadjust(cv.bilateralFilter(si100Wnr,'SigmaSpace',10,'SigmaColor',22,'Diameter',11));
si100WnrNLM = NLMF(im2double(si100Wnr),Options);
[NA si100WnrBM3D] = BM3D(1,si100Wnr,49);

si100CLSFTV = imadjust(cv.denoise_TVL1(si100CLSF,'Lambda',0.92));
si100CLSFBF = imadjust(cv.bilateralFilter(si100CLSF,'SigmaSpace',10,'SigmaColor',22,'Diameter',11));
si100CLSFNLM = NLMF(im2double(si100CLSF),Options);
[NA si100CLSFBM3D] = BM3D(1,si100CLSF,49);

si100RLTV = imadjust(cv.denoise_TVL1(si100RL,'Lambda',0.92));
si100RLBF = imadjust(cv.bilateralFilter(si100RL,'SigmaSpace',10,'SigmaColor',22,'Diameter',11));
si100RLNLM = NLMF(im2double(si100RL),Options);
[NA si100RLBM3D] = BM3D(1,si100RL,49);

simemWnrTV = imadjust(cv.denoise_TVL1(simemWnr,'Lambda',0.92));
simemWnrBF = imadjust(cv.bilateralFilter(simemWnr,'SigmaSpace',10,'SigmaColor',22,'Diameter',11));
simemWnrNLM = NLMF(im2double(simemWnr),Options);
[NA simemWnrBM3D] = BM3D(1,simemWnr,49);

simemCLSFTV = imadjust(cv.denoise_TVL1(simemCLSF,'Lambda',0.92));
simemCLSFBF = imadjust(cv.bilateralFilter(simemCLSF,'SigmaSpace',10,'SigmaColor',22,'Diameter',11));
simemCLSFNLM = NLMF(im2double(simemCLSF),Options);
[NA simemCLSFBM3D] = BM3D(1,simemCLSF,49);

simemRLTV = imadjust(cv.denoise_TVL1(simemRL,'Lambda',0.92));
simemRLBF = imadjust(cv.bilateralFilter(simemRL,'SigmaSpace',10,'SigmaColor',22,'Diameter',11));
simemRLNLM = NLMF(im2double(simemRL),Options);
[NA simemRLBM3D] = BM3D(1,simemRL,49);

bloch_zWnrTV = imadjust(cv.denoise_TVL1(bloch_zWnr,'Lambda',0.92));
bloch_zWnrBF = imadjust(cv.bilateralFilter(bloch_zWnr,'SigmaSpace',10,'SigmaColor',22,'Diameter',11));
bloch_zWnrNLM = NLMF(im2double(bloch_zWnr),Options);
[NA bloch_zWnrBM3D] = BM3D(1,bloch_zWnr,49);

bloch_zCLSFTV = imadjust(cv.denoise_TVL1(bloch_zCLSF,'Lambda',0.92));
bloch_zCLSFBF = imadjust(cv.bilateralFilter(bloch_zCLSF,'SigmaSpace',10,'SigmaColor',22,'Diameter',11));
bloch_zCLSFNLM = NLMF(im2double(bloch_zCLSF),Options);
[NA bloch_zCLSFBM3D] = BM3D(1,bloch_zCLSF,49);

bloch_zRLTV = imadjust(cv.denoise_TVL1(bloch_zRL,'Lambda',0.92));
bloch_zRLBF = imadjust(cv.bilateralFilter(bloch_zRL,'SigmaSpace',10,'SigmaColor',22,'Diameter',11));
bloch_zRLNLM = NLMF(im2double(bloch_zRL),Options);
[NA bloch_zRLBM3D] = BM3D(1,bloch_zRL,49);

neel_zWnrTV = imadjust(cv.denoise_TVL1(neel_zWnr,'Lambda',0.92));
neel_zWnrBF = imadjust(cv.bilateralFilter(neel_zWnr,'SigmaSpace',10,'SigmaColor',22,'Diameter',11));
neel_zWnrNLM = NLMF(im2double(neel_zWnr),Options);
[NA neel_zWnrBM3D] = BM3D(1,neel_zWnr,49);

neel_zCLSFTV = imadjust(cv.denoise_TVL1(neel_zCLSF,'Lambda',0.92));
neel_zCLSFBF = imadjust(cv.bilateralFilter(neel_zCLSF,'SigmaSpace',10,'SigmaColor',22,'Diameter',11));
neel_zCLSFNLM = NLMF(im2double(neel_zCLSF),Options);
[NA neel_zCLSFBM3D] = BM3D(1,neel_zCLSF,49);

neel_zRLTV = imadjust(cv.denoise_TVL1(neel_zRL,'Lambda',0.92));
neel_zRLBF = imadjust(cv.bilateralFilter(neel_zRL,'SigmaSpace',10,'SigmaColor',22,'Diameter',11));
neel_zRLNLM = NLMF(im2double(neel_zRL),Options);
[NA neel_zRLBM3D] = BM3D(1,neel_zRL,49);

% subplot(321);imshow(boron);
% title('Original');
% subplot(322);imshow(boronRL);
% title('Deconvoluida');
% subplot(323);imshow(boronRLTV);
% title('TV');
% subplot(324);imshow(boronRLBF);
% title('BF');
% subplot(325);imshow(boronRLNLM);
% title('NLM');
% subplot(326);imshow(boronRLBM3D);
% title('BM3D)');

imwrite(i100msWnrTV,'/home/welinton/Desktop/FramesVideos/frames/result/100msWnrTV.png');
imwrite(i100msWnrBF,'/home/welinton/Desktop/FramesVideos/frames/result/100msWnrBF.png');
imwrite(i100msWnrNLM,'/home/welinton/Desktop/FramesVideos/frames/result/100msWnrNLM.png');
imwrite(i100msWnrBM3D,'/home/welinton/Desktop/FramesVideos/frames/result/100msWnrBM3D.png');

imwrite(i100msCLSFTV,'/home/welinton/Desktop/FramesVideos/frames/result/100msCLSFTV.png');
imwrite(i100msCLSFBF,'/home/welinton/Desktop/FramesVideos/frames/result/100msCLSFBF.png');
imwrite(i100msCLSFNLM,'/home/welinton/Desktop/FramesVideos/frames/result/100msCLSFNLM.png');
imwrite(i100msCLSFBM3D,'/home/welinton/Desktop/FramesVideos/frames/result/100msCLSFBM3D.png');

imwrite(i100msRLTV,'/home/welinton/Desktop/FramesVideos/frames/result/100msRLTV.png');
imwrite(i100msRLBF,'/home/welinton/Desktop/FramesVideos/frames/result/100msRLBF.png');
imwrite(i100msRLNLM,'/home/welinton/Desktop/FramesVideos/frames/result/100msRLNLM.png');
imwrite(i100msRLBM3D,'/home/welinton/Desktop/FramesVideos/frames/result/100msRLBM3D.png');

imwrite(boronWnrTV,'/home/welinton/Desktop/FramesVideos/frames/result/boronWnrTV.png');
imwrite(boronWnrBF,'/home/welinton/Desktop/FramesVideos/frames/result/boronWnrBF.png');
imwrite(boronWnrNLM,'/home/welinton/Desktop/FramesVideos/frames/result/boronWnrNLM.png');
imwrite(boronWnrBM3D,'/home/welinton/Desktop/FramesVideos/frames/result/boronWnrBM3D.png');

imwrite(boronCLSFTV,'/home/welinton/Desktop/FramesVideos/frames/result/boronCLSFTV.png');
imwrite(boronCLSFBF,'/home/welinton/Desktop/FramesVideos/frames/result/boronCLSFBF.png');
imwrite(boronCLSFNLM,'/home/welinton/Desktop/FramesVideos/frames/result/boronCLSFNLM.png');
imwrite(boronCLSFBM3D,'/home/welinton/Desktop/FramesVideos/frames/result/boronCLSFBM3D.png');

imwrite(boronRLTV,'/home/welinton/Desktop/FramesVideos/frames/result/boronRLTV.png');
imwrite(boronRLBF,'/home/welinton/Desktop/FramesVideos/frames/result/boronRLBF.png');
imwrite(boronRLNLM,'/home/welinton/Desktop/FramesVideos/frames/result/boronRLNLM.png');
imwrite(boronRLBM3D,'/home/welinton/Desktop/FramesVideos/frames/result/boronRLBM3D.png');

imwrite(gaasWnrTV,'/home/welinton/Desktop/FramesVideos/frames/result/gaasWnrTV.png');
imwrite(gaasWnrBF,'/home/welinton/Desktop/FramesVideos/frames/result/gaasWnrBF.png');
imwrite(gaasWnrNLM,'/home/welinton/Desktop/FramesVideos/frames/result/gaasWnrNLM.png');
imwrite(gaasWnrBM3D,'/home/welinton/Desktop/FramesVideos/frames/result/gaasWnrBM3D.png');

imwrite(gaasCLSFTV,'/home/welinton/Desktop/FramesVideos/frames/result/gaasCLSFTV.png');
imwrite(gaasCLSFBF,'/home/welinton/Desktop/FramesVideos/frames/result/gaasCLSFBF.png');
imwrite(gaasCLSFNLM,'/home/welinton/Desktop/FramesVideos/frames/result/gaasCLSFNLM.png');
imwrite(gaasCLSFBM3D,'/home/welinton/Desktop/FramesVideos/frames/result/gaasCLSFBM3D.png');

imwrite(gaasRLTV,'/home/welinton/Desktop/FramesVideos/frames/result/gaasRLTV.png');
imwrite(gaasRLBF,'/home/welinton/Desktop/FramesVideos/frames/result/gaasRLBF.png');
imwrite(gaasRLNLM,'/home/welinton/Desktop/FramesVideos/frames/result/gaasRLNLM.png');
imwrite(gaasRLBM3D,'/home/welinton/Desktop/FramesVideos/frames/result/gaasRLBM3D.png');

imwrite(graphWnrTV,'/home/welinton/Desktop/FramesVideos/frames/result/graphWnrTV.png');
imwrite(graphWnrBF,'/home/welinton/Desktop/FramesVideos/frames/result/graphWnrBF.png');
imwrite(graphWnrNLM,'/home/welinton/Desktop/FramesVideos/frames/result/graphWnrNLM.png');
imwrite(graphWnrBM3D,'/home/welinton/Desktop/FramesVideos/frames/result/graphWnrBM3D.png');

imwrite(graphCLSFTV,'/home/welinton/Desktop/FramesVideos/frames/result/graphCLSFTV.png');
imwrite(graphCLSFBF,'/home/welinton/Desktop/FramesVideos/frames/result/graphCLSFBF.png');
imwrite(graphCLSFNLM,'/home/welinton/Desktop/FramesVideos/frames/result/graphCLSFNLM.png');
imwrite(graphCLSFBM3D,'/home/welinton/Desktop/FramesVideos/frames/result/graphCLSFBM3D.png');

imwrite(graphRLTV,'/home/welinton/Desktop/FramesVideos/frames/result/graphRLTV.png');
imwrite(graphRLBF,'/home/welinton/Desktop/FramesVideos/frames/result/graphRLBF.png');
imwrite(graphRLNLM,'/home/welinton/Desktop/FramesVideos/frames/result/graphRLNLM.png');
imwrite(graphRLBM3D,'/home/welinton/Desktop/FramesVideos/frames/result/graphRLBM3D.png');

imwrite(moviewWnrTV,'/home/welinton/Desktop/FramesVideos/frames/result/moviewWnrTV.png');
imwrite(moviewWnrBF,'/home/welinton/Desktop/FramesVideos/frames/result/moviewWnrBF.png');
imwrite(moviewWnrNLM,'/home/welinton/Desktop/FramesVideos/frames/result/moviewWnrNLM.png');
imwrite(moviewWnrBM3D,'/home/welinton/Desktop/FramesVideos/frames/result/moviewWnrBM3D.png');

imwrite(moviewCLSFTV,'/home/welinton/Desktop/FramesVideos/frames/result/moviewCLSFTV.png');
imwrite(moviewCLSFBF,'/home/welinton/Desktop/FramesVideos/frames/result/moviewCLSFBF.png');
imwrite(moviewCLSFNLM,'/home/welinton/Desktop/FramesVideos/frames/result/moviewCLSFNLM.png');
imwrite(moviewCLSFBM3D,'/home/welinton/Desktop/FramesVideos/frames/result/moviewCLSFBM3D.png');

imwrite(moviewRLTV,'/home/welinton/Desktop/FramesVideos/frames/result/moviewRLTV.png');
imwrite(moviewRLBF,'/home/welinton/Desktop/FramesVideos/frames/result/moviewRLBF.png');
imwrite(moviewRLNLM,'/home/welinton/Desktop/FramesVideos/frames/result/moviewRLNLM.png');
imwrite(moviewRLBM3D,'/home/welinton/Desktop/FramesVideos/frames/result/moviewRLBM3D.png');

imwrite(nial1WnrTV,'/home/welinton/Desktop/FramesVideos/frames/result/nial1WnrTV.png');
imwrite(nial1WnrBF,'/home/welinton/Desktop/FramesVideos/frames/result/nial1WnrBF.png');
imwrite(nial1WnrNLM,'/home/welinton/Desktop/FramesVideos/frames/result/nial1WnrNLM.png');
imwrite(nial1WnrBM3D,'/home/welinton/Desktop/FramesVideos/frames/result/nial1WnrBM3D.png');

imwrite(nial1CLSFTV,'/home/welinton/Desktop/FramesVideos/frames/result/nial1CLSFTV.png');
imwrite(nial1CLSFBF,'/home/welinton/Desktop/FramesVideos/frames/result/nial1CLSFBF.png');
imwrite(nial1CLSFNLM,'/home/welinton/Desktop/FramesVideos/frames/result/nial1CLSFNLM.png');
imwrite(nial1CLSFBM3D,'/home/welinton/Desktop/FramesVideos/frames/result/nial1CLSFBM3D.png');

imwrite(nial1RLTV,'/home/welinton/Desktop/FramesVideos/frames/result/nial1RLTV.png');
imwrite(nial1RLBF,'/home/welinton/Desktop/FramesVideos/frames/result/nial1RLBF.png');
imwrite(nial1RLNLM,'/home/welinton/Desktop/FramesVideos/frames/result/nial1RLNLM.png');
imwrite(nial1RLBM3D,'/home/welinton/Desktop/FramesVideos/frames/result/nial1RLBM3D.png');

imwrite(nial2WnrTV,'/home/welinton/Desktop/FramesVideos/frames/result/nial2WnrTV.png');
imwrite(nial2WnrBF,'/home/welinton/Desktop/FramesVideos/frames/result/nial2WnrBF.png');
imwrite(nial2WnrNLM,'/home/welinton/Desktop/FramesVideos/frames/result/nial2WnrNLM.png');
imwrite(nial2WnrBM3D,'/home/welinton/Desktop/FramesVideos/frames/result/nial2WnrBM3D.png');

imwrite(nial2CLSFTV,'/home/welinton/Desktop/FramesVideos/frames/result/nial2CLSFTV.png');
imwrite(nial2CLSFBF,'/home/welinton/Desktop/FramesVideos/frames/result/nial2CLSFBF.png');
imwrite(nial2CLSFNLM,'/home/welinton/Desktop/FramesVideos/frames/result/nial2CLSFNLM.png');
imwrite(nial2CLSFBM3D,'/home/welinton/Desktop/FramesVideos/frames/result/nial2CLSFBM3D.png');

imwrite(nial2RLTV,'/home/welinton/Desktop/FramesVideos/frames/result/nial2RLTV.png');
imwrite(nial2RLBF,'/home/welinton/Desktop/FramesVideos/frames/result/nial2RLBF.png');
imwrite(nial2RLNLM,'/home/welinton/Desktop/FramesVideos/frames/result/nial2RLNLM.png');
imwrite(nial2RLBM3D,'/home/welinton/Desktop/FramesVideos/frames/result/nial2RLBM3D.png');

imwrite(nial3WnrTV,'/home/welinton/Desktop/FramesVideos/frames/result/nial3WnrTV.png');
imwrite(nial3WnrBF,'/home/welinton/Desktop/FramesVideos/frames/result/nial3WnrBF.png');
imwrite(nial3WnrNLM,'/home/welinton/Desktop/FramesVideos/frames/result/nial3WnrNLM.png');
imwrite(nial3WnrBM3D,'/home/welinton/Desktop/FramesVideos/frames/result/nial3WnrBM3D.png');

imwrite(nial3CLSFTV,'/home/welinton/Desktop/FramesVideos/frames/result/nial3CLSFTV.png');
imwrite(nial3CLSFBF,'/home/welinton/Desktop/FramesVideos/frames/result/nial3CLSFBF.png');
imwrite(nial3CLSFNLM,'/home/welinton/Desktop/FramesVideos/frames/result/nial3CLSFNLM.png');
imwrite(nial3CLSFBM3D,'/home/welinton/Desktop/FramesVideos/frames/result/nial3CLSFBM3D.png');

imwrite(nial3RLTV,'/home/welinton/Desktop/FramesVideos/frames/result/nial3RLTV.png');
imwrite(nial3RLBF,'/home/welinton/Desktop/FramesVideos/frames/result/nial3RLBF.png');
imwrite(nial3RLNLM,'/home/welinton/Desktop/FramesVideos/frames/result/nial3RLNLM.png');
imwrite(nial3RLBM3D,'/home/welinton/Desktop/FramesVideos/frames/result/nial3RLBM3D.png');

imwrite(nial4WnrTV,'/home/welinton/Desktop/FramesVideos/frames/result/nial4WnrTV.png');
imwrite(nial4WnrBF,'/home/welinton/Desktop/FramesVideos/frames/result/nial4WnrBF.png');
imwrite(nial4WnrNLM,'/home/welinton/Desktop/FramesVideos/frames/result/nial4WnrNLM.png');
imwrite(nial4WnrBM3D,'/home/welinton/Desktop/FramesVideos/frames/result/nial4WnrBM3D.png');

imwrite(nial4CLSFTV,'/home/welinton/Desktop/FramesVideos/frames/result/nial4CLSFTV.png');
imwrite(nial4CLSFBF,'/home/welinton/Desktop/FramesVideos/frames/result/nial4CLSFBF.png');
imwrite(nial4CLSFNLM,'/home/welinton/Desktop/FramesVideos/frames/result/nial4CLSFNLM.png');
imwrite(nial4CLSFBM3D,'/home/welinton/Desktop/FramesVideos/frames/result/nial4CLSFBM3D.png');

imwrite(nial4RLTV,'/home/welinton/Desktop/FramesVideos/frames/result/nial4RLTV.png');
imwrite(nial4RLBF,'/home/welinton/Desktop/FramesVideos/frames/result/nial4RLBF.png');
imwrite(nial4RLNLM,'/home/welinton/Desktop/FramesVideos/frames/result/nial4RLNLM.png');
imwrite(nial4RLBM3D,'/home/welinton/Desktop/FramesVideos/frames/result/nial4RLBM3D.png');

imwrite(pbcuWnrTV,'/home/welinton/Desktop/FramesVideos/frames/result/pbcuWnrTV.png');
imwrite(pbcuWnrBF,'/home/welinton/Desktop/FramesVideos/frames/result/pbcuWnrBF.png');
imwrite(pbcuWnrNLM,'/home/welinton/Desktop/FramesVideos/frames/result/pbcuWnrNLM.png');
imwrite(pbcuWnrBM3D,'/home/welinton/Desktop/FramesVideos/frames/result/pbcuWnrBM3D.png');

imwrite(pbcuCLSFTV,'/home/welinton/Desktop/FramesVideos/frames/result/pbcuCLSFTV.png');
imwrite(pbcuCLSFBF ,'/home/welinton/Desktop/FramesVideos/frames/result/pbcuCLSFBF.png');
imwrite(pbcuCLSFNLM,'/home/welinton/Desktop/FramesVideos/frames/result/pbcuCLSFNLM.png');
imwrite(pbcuCLSFBM3D,'/home/welinton/Desktop/FramesVideos/frames/result/pbcuCLSFBM3D.png');

imwrite(pbcuRLTV,'/home/welinton/Desktop/FramesVideos/frames/result/pbcuRLTV.png');
imwrite(pbcuRLBF,'/home/welinton/Desktop/FramesVideos/frames/result/pbcuRLBF.png');
imwrite(pbcuRLNLM,'/home/welinton/Desktop/FramesVideos/frames/result/pbcuRLNLM.png');
imwrite(pbcuRLBM3D,'/home/welinton/Desktop/FramesVideos/frames/result/pbcuRLBM3D.png');

imwrite(si001WnrTV,'/home/welinton/Desktop/FramesVideos/frames/result/si001WnrTV.png');
imwrite(si001WnrBF,'/home/welinton/Desktop/FramesVideos/frames/result/si001WnrBF.png');
imwrite(si001WnrNLM,'/home/welinton/Desktop/FramesVideos/frames/result/si001WnrNLM.png');
imwrite(si001WnrBM3D,'/home/welinton/Desktop/FramesVideos/frames/result/si001WnrBM3D.png');

imwrite(si001CLSFTV,'/home/welinton/Desktop/FramesVideos/frames/result/si001CLSFTV.png');
imwrite(si001CLSFBF,'/home/welinton/Desktop/FramesVideos/frames/result/si001CLSFBF.png');
imwrite(si001CLSFNLM,'/home/welinton/Desktop/FramesVideos/frames/result/si001CLSFNLM.png');
imwrite(si001CLSFBM3D,'/home/welinton/Desktop/FramesVideos/frames/result/si001CLSFBM3D.png');

imwrite(si001RLTV,'/home/welinton/Desktop/FramesVideos/frames/result/si001RLTV.png');
imwrite(si001RLBF,'/home/welinton/Desktop/FramesVideos/frames/result/si001RLBF.png');
imwrite(si001RLNLM,'/home/welinton/Desktop/FramesVideos/frames/result/si001RLNLM.png');
imwrite(si001RLBM3D,'/home/welinton/Desktop/FramesVideos/frames/result/si001RLBM3D.png');

imwrite(si10WnrTV,'/home/welinton/Desktop/FramesVideos/frames/result/si10WnrTV.png');
imwrite(si10WnrBF,'/home/welinton/Desktop/FramesVideos/frames/result/si10WnrBF.png');
imwrite(si10WnrNLM,'/home/welinton/Desktop/FramesVideos/frames/result/si10WnrNLM.png');
imwrite(si10WnrBM3D,'/home/welinton/Desktop/FramesVideos/frames/result/si10WnrBM3D.png');

imwrite(si10CLSFTV,'/home/welinton/Desktop/FramesVideos/frames/result/si10CLSFTV.png');
imwrite(si10CLSFBF,'/home/welinton/Desktop/FramesVideos/frames/result/si10CLSFBF.png');
imwrite(si10CLSFNLM,'/home/welinton/Desktop/FramesVideos/frames/result/si10CLSFNLM.png');
imwrite(si10CLSFBM3D,'/home/welinton/Desktop/FramesVideos/frames/result/si10CLSFBM3D.png');

imwrite(si10RLTV,'/home/welinton/Desktop/FramesVideos/frames/result/si10RLTV.png');
imwrite(si10RLBF,'/home/welinton/Desktop/FramesVideos/frames/result/si10RLBF.png');
imwrite(si10RLNLM,'/home/welinton/Desktop/FramesVideos/frames/result/si10RLNLM.png');
imwrite(si10RLBM3D,'/home/welinton/Desktop/FramesVideos/frames/result/si10RLBM3D.png');

imwrite(si100WnrTV,'/home/welinton/Desktop/FramesVideos/frames/result/si100WnrTV.png');
imwrite(si100WnrBF,'/home/welinton/Desktop/FramesVideos/frames/result/si100WnrBF.png');
imwrite(si100WnrNLM,'/home/welinton/Desktop/FramesVideos/frames/result/si100WnrNLM.png');
imwrite(si100WnrBM3D,'/home/welinton/Desktop/FramesVideos/frames/result/si100WnrBM3D.png');

imwrite(si100CLSFTV,'/home/welinton/Desktop/FramesVideos/frames/result/si100CLSFTV.png');
imwrite(si100CLSFBF,'/home/welinton/Desktop/FramesVideos/frames/result/si100CLSFBF.png');
imwrite(si100CLSFNLM,'/home/welinton/Desktop/FramesVideos/frames/result/si100CLSFNLM.png');
imwrite(si100CLSFBM3D,'/home/welinton/Desktop/FramesVideos/frames/result/si100CLSFBM3D.png');

imwrite(si100RLTV,'/home/welinton/Desktop/FramesVideos/frames/result/si100RLTV.png');
imwrite(si100RLBF,'/home/welinton/Desktop/FramesVideos/frames/result/si100RLBF.png');
imwrite(si100RLNLM,'/home/welinton/Desktop/FramesVideos/frames/result/si100RLNLM.png');
imwrite(si100RLBM3D,'/home/welinton/Desktop/FramesVideos/frames/result/si100RLBM3D.png');

imwrite(simemWnrTV,'/home/welinton/Desktop/FramesVideos/frames/result/simemWnrTV.png');
imwrite(simemWnrBF,'/home/welinton/Desktop/FramesVideos/frames/result/simemWnrBF.png');
imwrite(simemWnrNLM,'/home/welinton/Desktop/FramesVideos/frames/result/simemWnrNLM.png');
imwrite(simemWnrBM3D,'/home/welinton/Desktop/FramesVideos/frames/result/simemWnrBM3D.png');

imwrite(simemCLSFTV,'/home/welinton/Desktop/FramesVideos/frames/result/simemCLSFTV.png');
imwrite(simemCLSFBF,'/home/welinton/Desktop/FramesVideos/frames/result/simemCLSFBF.png');
imwrite(simemCLSFNLM,'/home/welinton/Desktop/FramesVideos/frames/result/simemCLSFNLM.png');
imwrite(simemCLSFBM3D,'/home/welinton/Desktop/FramesVideos/frames/result/simemCLSFBM3D.png');

imwrite(simemRLTV,'/home/welinton/Desktop/FramesVideos/frames/result/simemRLTV.png');
imwrite(simemRLBF,'/home/welinton/Desktop/FramesVideos/frames/result/simemRLBF.png');
imwrite(simemRLNLM,'/home/welinton/Desktop/FramesVideos/frames/result/simemRLNLM.png');
imwrite(simemRLBM3D,'/home/welinton/Desktop/FramesVideos/frames/result/simemRLBM3D.png');

imwrite(bloch_zWnrTV,'/home/welinton/Desktop/FramesVideos/frames/result/bloch_zWnrTV.png');
imwrite(bloch_zWnrBF,'/home/welinton/Desktop/FramesVideos/frames/result/bloch_zWnrBF.png');
imwrite(bloch_zWnrNLM,'/home/welinton/Desktop/FramesVideos/frames/result/bloch_zWnrNLM.png');
imwrite(bloch_zWnrBM3D,'/home/welinton/Desktop/FramesVideos/frames/result/bloch_zWnrBM3D.png');

imwrite(bloch_zCLSFTV,'/home/welinton/Desktop/FramesVideos/frames/result/bloch_zCLSFTV.png');
imwrite(bloch_zCLSFBF,'/home/welinton/Desktop/FramesVideos/frames/result/bloch_zCLSFBF.png');
imwrite(bloch_zCLSFNLM,'/home/welinton/Desktop/FramesVideos/frames/result/bloch_zCLSFNLM.png');
imwrite(bloch_zCLSFBM3D,'/home/welinton/Desktop/FramesVideos/frames/result/bloch_zCLSFBM3D.png');

imwrite(bloch_zRLTV,'/home/welinton/Desktop/FramesVideos/frames/result/bloch_zRLTV.png');
imwrite(bloch_zRLBF,'/home/welinton/Desktop/FramesVideos/frames/result/bloch_zRLBF.png');
imwrite(bloch_zRLNLM,'/home/welinton/Desktop/FramesVideos/frames/result/bloch_zRLNLM.png');
imwrite(bloch_zRLBM3D,'/home/welinton/Desktop/FramesVideos/frames/result/bloch_zRLBM3D.png');

imwrite(neel_zWnrTV,'/home/welinton/Desktop/FramesVideos/frames/result/neel_zWnrTV.png');
imwrite(neel_zWnrBF,'/home/welinton/Desktop/FramesVideos/frames/result/neel_zWnrBF.png');
imwrite(neel_zWnrNLM,'/home/welinton/Desktop/FramesVideos/frames/result/neel_zWnrNLM.png');
imwrite(neel_zWnrBM3D,'/home/welinton/Desktop/FramesVideos/frames/result/neel_zWnrBM3D.png');

imwrite(neel_zCLSFTV,'/home/welinton/Desktop/FramesVideos/frames/result/neel_zCLSFTV.png');
imwrite(neel_zCLSFBF,'/home/welinton/Desktop/FramesVideos/frames/result/neel_zCLSFBF.png');
imwrite(neel_zCLSFNLM,'/home/welinton/Desktop/FramesVideos/frames/result/neel_zCLSFNLM.png');
imwrite(neel_zCLSFBM3D,'/home/welinton/Desktop/FramesVideos/frames/result/neel_zCLSFBM3D.png');

imwrite(neel_zRLTV,'/home/welinton/Desktop/FramesVideos/frames/result/neel_zRLTV.png');
imwrite(neel_zRLBF,'/home/welinton/Desktop/FramesVideos/frames/result/neel_zRLBF.png');
imwrite(neel_zRLNLM,'/home/welinton/Desktop/FramesVideos/frames/result/neel_zRLNLM.png');
imwrite(neel_zRLBM3D,'/home/welinton/Desktop/FramesVideos/frames/result/neel_zRLBM3D.png');









