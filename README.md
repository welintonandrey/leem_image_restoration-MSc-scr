# README #

This repository contains all scritps, algoritms and links for others algorithms, that were used in my MSc Dissertation. 

***

### EXTERNAL ALGORITHMS AND DEPENDENCIES###

The external algorithms used in this work can be download in the following links:

#### Denoising ####
* **OpenCV**: (http://opencv.org/downloads.html)
* **MexOpenCV**: [MexOpenCV - GitHub Kyamagu](https://github.com/kyamagu/mexopencv)
* **Total Variation**: MexOpenCV above
* **Bilateral**: MexOpenCV above
* **Adaptive Bilateral**: OpenCV 2.4
* **Fast Non-Local Means**: [File Exchange MathWorks](https://www.mathworks.com/matlabcentral/fileexchange/27395-fast-non-local-means-1d--2d-color-and-3d)
* **BM3D**: [Alessandro Foi webpage](http://www.cs.tut.fi/~foi/GCF-BM3D/BM3D.zip) [1]

#### Quality Measures ####
* **PSNR.m** [File Exchange MathWorks](http://www.mathworks.com/matlabcentral/fileexchange/29049-wavelet-decomposition-for-images/content/PSNR.m)
* **SSIM.m** [File Exchange MathWorks](https://www.mathworks.com/matlabcentral/fileexchange/44971-image-denoising-using-modified-perona-malik-model-based-on-directional-laplacian/content/ssim.m)

#### Goodness of Fit ####

* **FitMeThis.m**: [File Exchange MathWorks](https://www.mathworks.com/matlabcentral/fileexchange/40167-fitmethis)
* **AllFitDist.m**: [File Exchange MathWorks](https://www.mathworks.com/matlabcentral/fileexchange/34943-fit-all-valid-parametric-probability-distributions-to-data)

#### PSF estimation ####

* **Fast motion deblurring **:  Sunghyun and Seungyong source code [2]

***

### DATASET ###

All datasets used in this work can be downloaded at the following links:

* **Datasets provided by Prof. Dr. Wen-Xin Tang**: [Data Dr. Wen-Xin Tang](https://1drv.ms/f/s!AgzhhDpbuwDfjg5mAfOkk5XeU4Li)
* **Datasets provided by Prof. Dr. Gong Chen**: [Data Dr Gong Chen](https://1drv.ms/f/s!AgzhhDpbuwDf305pWErjCO5QjtS-)
* **Rogge et al. [3]**: (http://www.nature.com/ncomms/2015/150420/ncomms7880/full/ncomms7880.html)
* **Qin et al. [4]**: (http://www.pnas.org/content/112/2/E103.abstract)
* **OneDrive with all data**: [OneDrive](https://1drv.ms/f/s!AgzhhDpbuwDfjV8_w5sUVhfQZ9Bn)

***

### EXPERIMENTS ###

#### Experiment One  ####

**1 - Noise**

The results of the histogram fitting can be done running the file **/tests/fit_dist_noise/testes_distribuicoes.m** or using the methods **FitMeThis.m** and **AllFitDist.m**.
Take the pixels of a homogeneous region of the image that contains noisy. Pass these pixels as a vector for the methods. Will return the probability distribution. As the pictures below:

Get pixels in homogeneous region:

![GetHistogram](/tests/fit_dist_noise/fitsample/nial1_hist.png)

Sample fit with **AllFitDist.m**:

![Fit](/tests/fit_dist_noise/fitsample/fit-gauss.png)

Do this for all videos!

**2 - PSF estimation**

Using the source code [2] (Windows O.S. only) you can estimate the PSF for one picture. Use this source of all images and compute an average of all, then you will get the estimated PSF for each equipment.

**3 - Artificial images**

Using the noise levels calculated above and the PSF, you can generate news imagens for tests:

Only Noise:
```
for v = 1:length(allNoiseLevel)
    res(v).image = imnoise(mat2gray(imgtest),'gaussian',0,allNoiseLevel(v)/10);
    res(v).psnr = PSNR(imgtest,res(1,v).image);
    res(v).ssim = ssim(uint8(255*imgtest),uint8(255*res(1,v).image));
end
```

Noise and Blur:
```
for v = 1:length(allNoiseLevel)
    res(v).image = imnoise(mat2gray(imgtest),'gaussian',0,allNoiseLevel(v)/10);
    res(v).image = mat2gray(imfilter(res(v).image, PSF));
    res(v).psnr = PSNR(imgtest,res(1,v).image);
    res(v).ssim = ssim(uint8(255*imgtest),uint8(255*res(1,v).image));
end
```

#### Experiment Two  ####

**Filtering image**
This experiment can be performed by running the script **/scripts/script_get_std_noise.m**. In this script you can also get too the best parameters of each algorithm, based on filtering the artificial images.

#### Experiment Three  ####

**Restoration - remove noise and blur**
This experiment can be performed by running the script **/scripts/script_get_std_noise_blur_ssim_imadjust.m**. In this script you can also get too the best parameters of each algorithm, based on filtering the artificial images.

#### Experiment Four  ####

This experiment is in another git repository available in [GitHub](?????). The tests performed by the same are explained in the article that will appear in SIBGRAPI 2016.

#### Experiment Five  ####

The last experiment can be performed by running the script **/scripts/filtrarTodosVideos.m**. This script will run all denoising and Deblur algorithms (and combinations thereof) in real LEEM images. All parameters were chosen from the results of three and four experiments.

***

### REFERENCES ###

[1]: DABOV, K.; FOI, A.; KATKOVNIK, V.; EGIAZARIAN, K. Image denoising by sparse 3-d transform-domain collaborative filtering. Image Processing, IEEE Transactions on, IEEE, v. 16, n. 8, p. 2080–2095, 2007.

[2]: CHO, S.; LEE, S. Fast motion deblurring. In: ACM. ACM Transactions on Graphics (TOG). [S.l.], 2009. v. 28, n. 5, p. 145.

[3]: ROGGE, P. C.; THÜRMER, K.; FOSTER, M. E.; MCCARTY, K. F.; DUBON, O. D.; BARTELT, N. C. Real-time observation of epitaxial graphene domain reorientation. Nature communications, Nature Publishing Group, v. 6, 2015.

[4]: QIN, H.; CHEN, X.; LI, L.; SUTTER, P. W.; ZHOU, G. Oxidation-driven surface dynamics onnial (100). Proceedings of the National Academy of Sciences, National Acad Sciences, v. 112, n. 2, p. E103–E109, 2015.
