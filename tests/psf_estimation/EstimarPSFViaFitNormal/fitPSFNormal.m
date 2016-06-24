function fitPSFNormal(image, size)

img = getPSF(image, size, 0);

for i=1:size
    
	%linha central horizontal 
    psfh(i) = img(floor(size/2) + 1, i);
	%linha central vertical
    psfv(i) = img(i, floor(size/2) + 1);
	%diagonal principal
    psfdp(i) = img(i,i);
	%diagonal secundária
    psfds(i) = img(i, floor(size-i)+1);
    
end

%----------------------------------------------------
% Horizontal
cont = 1;
values = [];
for i=1:size
    for j=1:psfh(i)
       values(cont) = i;
       cont = cont+1;
    end
end

x_psfh = values';
pd_h = fitdist(x_psfh,'Normal');
x_values = 1:1:size;
y_psfh = pdf(pd_h,x_values);

figure;plot(x_values,y_psfh*(double(max(psfh))/max(y_psfh)))
hold on, plot(psfh,'red');hold off


%----------------------------------------------------
% Vertical
cont = 1;
for i=1:size
    for j=1:psfv(i)
       values(cont) = i;
       cont = cont+1;
    end
end

x_psfv = values';
pd_v = fitdist(x_psfv,'Normal');
x_values = 1:1:size;
y_psfv = pdf(pd_v,x_values);

figure;plot(x_values,y_psfv*(double(max(psfv))/max(y_psfv)))
hold on, plot(psfv,'green');hold off

%----------------------------------------------------
% Diagonal Principal
cont = 1;
values = [];
for i=1:size
    for j=1:psfdp(i)
       values(cont) = i;
       cont = cont+1;
    end
end

x_psfdp = values';
pd_dp = fitdist(x_psfdp,'Normal');
x_values = 1:1:size;
y_psfdp = pdf(pd_dp,x_values);

figure;plot(x_values,y_psfdp*(double(max(psfdp))/max(y_psfdp)))
hold on, plot(psfdp,'black');hold off

%----------------------------------------------------
% Diagonal Secundária 
cont = 1;
values = [];
for i=1:size
    for j=1:psfds(i)
       values(cont) = i;
       cont = cont+1;
    end
end

x_psfds = values';
pd_ds = fitdist(x_psfds,'Normal');
x_values = 1:1:size;
y_psfds = pdf(pd_ds,x_values);

figure;plot(x_values,y_psfds*(double(max(psfds))/max(y_psfds)))
hold on, plot(psfds,'cyan');hold off

end
