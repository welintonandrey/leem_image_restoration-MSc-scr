close all
clear all

addpath('./external algorithms/bilateral/Bilateral Filtering/');
addpath('./external algorithms/tv/');
addpath('./external algorithms/BM3D/');
addpath('./external algorithms/fast_nlmeans/');
addpath('./external algorithms/PSNR/');
addpath('./external algorithms/SSIM/');
addpath(genpath('external algorithms/mexopencv-master'));

PSF = im2double(imread('psf.png'));
PSF = PSF ./ sum(PSF(:));

% filtraVideo('GaAsFringe','/home/welinton/Desktop/FramesVideos/videos/GaAsFringe.avi','/home/welinton/Desktop/FramesVideos/videos/result/',PSF,100);
% filtraVideo('GrapheneIr','/home/welinton/Desktop/FramesVideos/videos/GrapheneIr.mov','/home/welinton/Desktop/FramesVideos/videos/result/',PSF,100);
% filtraVideo('Moview','/home/welinton/Desktop/FramesVideos/videos/moview60fps.avi','/home/welinton/Desktop/FramesVideos/videos/result/',PSF,100);
% filtraVideo('BoronSi','/home/welinton/Desktop/FramesVideos/videos/Boron_Si.mov','/home/welinton/Desktop/FramesVideos/videos/result/',PSF,100);
% filtraVideo('PbCu','/home/welinton/Desktop/FramesVideos/videos/Pb_Cu.avi','/home/welinton/Desktop/FramesVideos/videos/result/',PSF,100);
% filtraVideo('NiAl01','/home/welinton/Desktop/FramesVideos/videos/NiAl01.avi','/home/welinton/Desktop/FramesVideos/videos/result/',PSF,100);
% filtraVideo('NiAl02','/home/welinton/Desktop/FramesVideos/videos/NiAl02.avi','/home/welinton/Desktop/FramesVideos/videos/result/',PSF,100);
% filtraVideo('NiAl03','/home/welinton/Desktop/FramesVideos/videos/NiAl03.avi','/home/welinton/Desktop/FramesVideos/videos/result/',PSF,100);
% filtraVideo('NiAl04','/home/welinton/Desktop/FramesVideos/videos/NiAl04.avi','/home/welinton/Desktop/FramesVideos/videos/result/',PSF,100);
filtraVideo('vSi_001_10um_500ms_LEEMmode','/home/welinton/Desktop/FramesVideos/videos/20150919-leem-df-si(001)-3.94-10-3.37g-1.avi','/home/welinton/Desktop/FramesVideos/videos/result/',PSF,100);
filtraVideo('vSi_100um_1000ms_PEEMmode','/home/welinton/Desktop/FramesVideos/videos/20150916-3.avi','/home/welinton/Desktop/FramesVideos/videos/result/',PSF,100);
filtraVideo('vSi_10um_1000ms_MEMmode','/home/welinton/Desktop/FramesVideos/videos/20150916-5.avi','/home/welinton/Desktop/FramesVideos/videos/result/',PSF,100);
filtraVideo('vSi_MEMmode_10um_200ms','/home/welinton/Desktop/FramesVideos/videos/20150918-1.avi','/home/welinton/Desktop/FramesVideos/videos/result/',PSF,100);