clear

I = double( imread('dataset/Barbara512.tif') );
W = double( imread('dataset/Peppers64.tif') );

%% Stage 1: Basic Texture Segmentation

lk_bin = basicTextureSegmentation(I,W);% Texture class label for block bk

% image(lk_bin, 'CDataMapping', 'scaled')
% colormap(gray(256)) %greyscale
% axis image

%% Stage 2: Texturizing the Logo to Match Each Host Block
%% Texturization Via the Arnold Transform
dictP = dictTextures(W);

figure(1)
subplot 121
image(dictP(:,:,24), 'CDataMapping', 'scaled')
colormap(gray(256)) %greyscale
axis image
subplot 122
image(W, 'CDataMapping', 'scaled')
colormap(gray(256)) %greyscale
axis image
% %%
% for i=1:64
% 	imwrite(dictP(:,:,i)/255,sprintf('fig/Fig4/%d.png', i));
% end

%% Quantifying the Visual Dissimilarity
% [features, visualization] = extractHOGFeatures(W_p,'CellSize', [L L], 'BlockSize', [1 1], 'NumBins', 9)
% h = extractHOGFeatures(W_p,'CellSize', [L L], 'BlockSize', [1 1], 'NumBins', 9);

best5 = best5HOG(I, lk_bin, W, dictP);

%% Gabor statistics
% 
% [mag,~] = imgaborfilt(W,2,0);
% image(mag, 'CDataMapping', 'scaled')
% colormap(gray(256)) %greyscale
% axis image
%%
c = gaborDecomposition(W);
C = reshape(c(2,4,:,:),64,64);
image(C, 'CDataMapping', 'scaled')
colormap(gray(256)) %greyscale
axis image

%% 
subbands = block1616Decomposition(W);

figure(4)

for t = 1:13
	subplot(1,13,t)
	image(reshape(subbands(t+13*12,:,:), 16,[]), 'CDataMapping', 'scaled')
	colormap(gray(256)) %greyscale
	axis image
end
figure(5)
image(W, 'CDataMapping', 'scaled')
colormap(gray(256)) %greyscale
axis image

	
%% results of HOG vs subband statistics

% test_im = dictP(:,:,24);
% eta = computeEta(W,test_im);
% Delta_cpk = sqrt(sum(eta.^2, 'all')/64^2);

% h_W = extractHOGFeatures(W,'CellSize', [64 64], 'BlockSize', [1 1], 'NumBins', 9);
% h_test = extractHOGFeatures(test_im,'CellSize', [64 64], 'BlockSize', [1 1], 'NumBins', 9);
% Delta_h = norm( h_W - h_test );
% 
% computeOverallDissimilarity(W, test_im);

%% minimise Dissimilarity
min_var = minimiseDissimilarity(I, best5, dictP);
min_img = read_minimiseDissimilarity(min_var);
image(min_img, 'CDataMapping', 'scaled')
colormap(gray(256)) %greyscale
axis image
%%
%imwrite(min_img/255, 'fig/Fig6_64.png');






