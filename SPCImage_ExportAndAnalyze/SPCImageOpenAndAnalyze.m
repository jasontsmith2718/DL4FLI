% Whatever file name you decided upon during export.
fN = 'NADH_AU565 2_';
% read in the t1, t2 and a1% for tM calculation.
t1 = dlmread([fN 't1.asc'])./1000;
t2 = dlmread([fN 't2.asc'])./1000;
a1 = dlmread([fN 'a1[%].asc'])./100;
tM = a1.*t1 + (1-a1).*t2;
% Read in the intensity 16-bit image for a fractional "photon-threshold".
I0 = double(imread([fN 'intensity_image.tif']))./2^16;

% Raw tM
figure; 
imagesc(tM); 
caxis([0.5 1.3]);

% crude photon-thresholding
I0m = I0;
I0m(I0m<.15) = 0;
figure; imagesc(I0m);
tM_dn = tM.*flipud(imbinarize(I0,.15));
figure; imagesc(tM_dn); caxis([0.5 1.3]);

% histogram
tMh = tM_dn;
tMh(tMh==0) = [];
figure; histogram(tMh);


