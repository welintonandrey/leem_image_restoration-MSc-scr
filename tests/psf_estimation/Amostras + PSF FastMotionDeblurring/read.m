
for frame=1:20
        str = strcat('out',sprintf('%d',frame),'.png.psf.png');

        im{frame} = imread(str);
        im{frame} = mat2gray(rgb2gray(im{frame}));

end

s = im{1};

for frame=2:20

    s = s + im{frame};
    
end

s = s / 20;