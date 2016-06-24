%i = rgb2gray(imread('/home/welinton/Desktop/testes/i.png'));
i = imread('/home/welinton/Desktop/Teste-Deblur/i.png');
psf = im2double(rgb2gray(imread('/home/welinton/Desktop/Teste-Deblur/i_Out.png.psf.png')));

i_wiener = deconvwnr(i,psf,0.025);
i_lucy = deconvlucy(i,psf,100);
i_reg = deconvreg(i,psf);
i_blind = deconvblind(i,psf,10);

i_wiener = i_wiener*(255/max(i_wiener(:)));
i_lucy = i_lucy*(255/max(i_lucy(:)));
i_reg = i_reg*(255/max(i_reg(:)));
i_blind = i_blind*(255/max(i_blind(:)));

[NA, i_bm3d_wiener] = BM3D(1, i_wiener, 25);
[NA, i_bm3d_lucy] = BM3D(1, i_lucy, 25);
[NA, i_bm3d_reg] = BM3D(1, i_reg, 25);
[NA, i_bm3d_blind] = BM3D(1, i_blind, 25);

figure, imshow(i);title('Original'),
figure, imshow(psf,[]);title('PSF'),

figure, imshow(i_wiener);title('Wiener'),
figure, imshow(i_lucy);title('Lucy'),
figure, imshow(i_reg);title('Regularized'),
figure, imshow(i_blind);title('Blind'),

figure, imshow(i_bm3d_wiener);title('Wiener+BM3D'),
figure, imshow(i_bm3d_lucy);title('Lucy+BM3D'),
figure, imshow(i_bm3d_reg);title('Regularized+BM3D'),
figure, imshow(i_bm3d_blind);title('Blind+BM3D')


% figure,
% subplot(2,3,1), imshow(i);title('Original'),
% subplot(2,3,2), imshow(psf,[]);title('PSF'),
% subplot(2,3,3), imshow(i_wiener);title('Wiener'),
% subplot(2,3,4), imshow(i_lucy);title('Lucy'),
% subplot(2,3,5), imshow(i_reg);title('Regularized'),
% subplot(2,3,6), imshow(i_blind);title('Blind')