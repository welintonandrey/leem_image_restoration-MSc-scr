%--------------------------------------------------------------------------------
%Leitura arquivo
vec = dlmread('vect_arq_moview.txt');
vec = vec(vec>0);

%Distribuições baseadas nos dados
pdf_normal = fitdist(vec,'Normal');
pdf_gama = fitdist(vec,'Gamma');
pdf_poisson = fitdist(vec,'Poisson');
pdf_invgauss = fitdist(vec,'InverseGaussian');

%Eixos
x = [0:1:255];
y_normal = pdf(pdf_normal,x);
y_gama = pdf(pdf_gama,x);
y_poisson = pdf(pdf_poisson,x);
y_invgauss = pdf(pdf_invgauss,x);

%Plot
hist(vec,255);

hold on
plot(x,y_normal*(312906/0.0125),'r','LineWidth',2);
plot(x,y_gama*(312906/0.0130),'g','LineWidth',2);
plot(x,y_poisson*(312906/0.0397),'k','LineWidth',2);
plot(x,y_invgauss*(312906/0.0098),'c','LineWidth',2);

%Legenda
legend('Histograma','Normal','Gamma','Poisson','InverseGaussian');

hold off
%--------------------------------------------------------------------------------

%--------------------------------------------------------------------------------
%Leitura arquivo
vec = dlmread('vect_arq_moview.txt');
vec = vec(vec>0);

%Distribuições baseadas nos dados
pdf_kernel = fitdist(vec,'Kernel');

%Eixos
x = [0:1:255];
y_kernel = pdf(pdf_kernel,x);

%Plot
hist(vec,255);

hold on
plot(x,y_kernel*(312906/0.0300),'r','LineWidth',2);
hold off
%--------------------------------------------------------------------------------

%--------------------------------------------------------------------------------
%Leitura arquivo
vec = dlmread('vect_arq_moview.txt');
vec = vec(vec>0);
vec1 = vec(vec<60);
vec2 = vec(vec>=60);

%Distribuições baseadas nos dados
pdf_normal1 = fitdist(vec1,'Normal');
pdf_gama1 = fitdist(vec1,'Gamma');
pdf_poisson1 = fitdist(vec1,'Poisson');
pdf_invgauss1 = fitdist(vec1,'InverseGaussian');

pdf_normal2 = fitdist(vec2,'Normal');
pdf_gama2 = fitdist(vec2,'Gamma');
pdf_poisson2 = fitdist(vec2,'Poisson');
pdf_invgauss2 = fitdist(vec2,'InverseGaussian');

%Eixos
x = [0:1:255];
y_normal1 = pdf(pdf_normal1,x);
y_gama1 = pdf(pdf_gama1,x);
y_poisson1 = pdf(pdf_poisson1,x);
y_invgauss1 = pdf(pdf_invgauss1,x);

y_normal2 = pdf(pdf_normal2,x);
y_gama2 = pdf(pdf_gama2,x);
y_poisson2 = pdf(pdf_poisson2,x);
y_invgauss2 = pdf(pdf_invgauss2,x);

%Plot
hist(vec,255);

hold on
plot(x,y_normal1*(119000/0.0320),'r','LineWidth',2);
plot(x,y_gama1*(119000/0.0269),'g','LineWidth',2);
plot(x,y_poisson1*(119000/0.0682),'k','LineWidth',2);
plot(x,y_invgauss1*(119000/0.0289),'c','LineWidth',2);

plot(x,y_normal2*(312906/0.0167),'r','LineWidth',2);
plot(x,y_gama2*(312906/0.0180),'g','LineWidth',2);
plot(x,y_poisson2*(312906/0.0384),'k','LineWidth',2);
plot(x,y_invgauss2*(312906/0.0186),'c','LineWidth',2);

%Legenda
legend('Histograma','Normal','Gamma','Poisson','InverseGaussian');

hold off
%--------------------------------------------------------------------------------

%--------------------------------------------------------------------------------
%Leitura arquivo
vec = dlmread('vect_arq_GaAsFringe.txt');
vec = vec(vec>18);
vec = vec(vec<248);

%Distribuições
pdf_normal = fitdist(vec,'Normal');
pdf_gama = fitdist(vec,'Gamma');
pdf_poisson = fitdist(vec,'Poisson');
pdf_invgauss = fitdist(vec,'InverseGaussian');

%Eixos
x = [0:1:255];
y_normal = pdf(pdf_normal,x);
y_gama = pdf(pdf_gama,x);
y_poisson = pdf(pdf_poisson,x);
y_invgauss = pdf(pdf_invgauss,x);

%Plot
hold off
>> hist(vec,255);

hold on
plot(x,y_normal*(211000/0.0106),'r','LineWidth',2);
plot(x,y_gama*(211000/0.0111),'g','LineWidth',2);
plot(x,y_poisson*(211000/0.0412),'k','LineWidth',2);
plot(x,y_invgauss*(211000/0.0117),'c','LineWidth',2);

%Legenda
legend('Histograma','Normal','Gamma','Poisson','InverseGaussian');

hold off
%--------------------------------------------------------------------------------

%--------------------------------------------------------------------------------
%Leitura arquivo
vec = dlmread('vect_arq_moview.txt');

%Remoção dos '0's e divisão em partes
vec = vec(vec>0);
vec1 = vec(vec<22);
vec2 = vec(vec>=22);
vec2 = vec2(vec2<60);
vec3 = vec(vec>=60);

%Calcula as distribuições e plota sobre o histograma
hold on

h3 = histfit(vec3,150,'inversegaussian');
h2 = histfit(vec2,38,'gamma');
h1 = histfit(vec1,22,'normal');
set(h3(2),'color','m');
set(h2(2),'color','g');

legend([h3(2),h2(2),h1(2)],'InverseGaussian','Gamma','Normal')

hold off
%--------------------------------------------------------------------------------

vec_boron = dlmread('vect_cresc_Boron.txt');
vec_gaas = dlmread('vect_cresc_GaAs.txt');
vec_moview = dlmread('vect_cresc_Moview.txt');
vec_pbcu = dlmread('vect_cresc_PbCu.txt');
vec_boron(463723) = 255;
vec_gaas(169725) = 255;
vec_pbcu(43052) = 255;
vec_moview(13903) = 255;

x = [0:1:255];

%Boron
dist_boron = fitdist(vec_boron,'Gamma');
y_boron = pdf(dist_boron,x);
y_boron = y_boron*(31000/0.0578);
hist(vec_boron,255);
hold on
plot(x,y_boron,'r','LineWidth',2);
legend('Histograma Video BoronSi.avi','Distribuição Gamma')
hold off

%GaAs
dist_gaas = fitdist(vec_gaas,'Normal');
y_gaas = pdf(dist_gaas,x);
y_gaas = y_gaas*(15000/0.0736);
hist(vec_gaas,255);
hold on
plot(x,y_gaas,'r','LineWidth',2);
legend('Histograma Video GaAsFringe.avi','Distribuição Normal')
hold off

%Moview
dist_mov = fitdist(vec_moview,'Gamma');
y_mov = pdf(dist_mov,x);
y_mov = y_mov*(1500/0.1016);
hist(vec_moview,255);
hold on
plot(x,y_mov,'r','LineWidth',2);
legend('Histograma Video moview60fps.avi','Distribuição Gamma')
hold off

%PbCu
dist_pbcu = fitdist(vec_pbcu,'Gamma');
y_pbcu = pdf(dist_pbcu,x);
y_pbcu = y_pbcu*(2600/0.0456);
hist(vec_pbcu,255);
hold on
plot(x,y_pbcu,'r','LineWidth',2);
legend('Histograma Video PbCu.avi','Distribuição Gamma')
hold off

%--------------------------------------------------------------------------------
i1 = imread('moview60fps.png');
i2 = imread('moview60fps2.png');
i1 = rgb2gray(i1);
i2 = rgb2gray(i2);
 
IPSF = ones(7,7);
 
[d1 PSF1] = deconvblind(i1,IPSF,10);
[d2 PSF2] = deconvblind(i2,IPSF,10);

subplot(221);imshow(i1);
title('Original 1');
subplot(222);imshow(i2);
title('Original 2');
subplot(223);imshow(d1);
title('Deblurred 1');
subplot(224);imshow(d2);
title('Deblureed 2');

subplot(221);imshow(PSF1,[]);title('PSF 1');
subplot(222);imshow(PSF2,[]);title('PSF 2');
subplot(223);imshow(d1);title('D1');
subplot(224);imshow(d2);title('D2');

%--------------------------------------------------------------------------------
%Histograma imagens LEEM

%Leitura arq
i = imread('200ms.bmp');
i = imcrop(i);
imhist(i);
ylim('auto');

%Imagem para vetor
vec = double(i(:));

%Distribuições
pdf_normal = fitdist(vec,'Normal');
pdf_gama = fitdist(vec,'Gamma');
pdf_poisson = fitdist(vec,'Poisson');

%Eixos
x = [0:1:255];
y_normal = pdf(pdf_normal,x);
y_gama = pdf(pdf_gama,x);
y_poisson = pdf(pdf_poisson,x);


%Plot
hold off
imhist(i);
ylim('auto');

hold on
plot(x,y_gama*(211000/0.0111),'g','LineWidth',2);
plot(x,y_normal*(211000/0.0106),'r','LineWidth',2);
plot(x,y_poisson*(211000/0.0412),'k','LineWidth',2);

%Legenda
legend('Histograma','Gamma','Normal','Poisson');

hold off


%--------------------------------------------------------------------------------
