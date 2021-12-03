function lk_bin = basicTextureSegmentation(I, W)
	% Following the notation given in the paper
	L = size(W,1);
	M_H = size(I,1);
	N_H = size(I,2);
	% For the Standar deviation map, the function
	% stdfilt() of Matlab can be used, since it does
	% what it's described in the paper. This function
	% uses a symmetric padding, which is useful for this 
	% application, since we are looking for texture zones.

	S = stdfilt(I);					% Standard deviation map
	S_tilde = zeros(size(S));		% Binarised and filled map

	beta = 0.1;						% As defined in the paper
	maxS = max(S, [], 'all');
	for y = 1:M_H
		for x = 1:N_H
			if S(y,x) >= beta*maxS
				S_tilde(y,x) = 1;
			end
		end
	end
	clear x y;
	% A binary image-closing is applied with a 9-pixel-radius disk 
	% structuring element
	% Juding from Fig.3.c, an approximation for the disk was used,
	% so the third argument of strel() is left as default
% 	S_backup = S_tilde;
	S_tilde = imclose(S_tilde, strel('disk',9));
	
	lk = zeros(M_H/L, N_H/L);		
	lk_bin = zeros(M_H/L, N_H/L);	% Class label texture
	
	for y = 1:size(lk,1)
		for x = 1:size(lk,2)
			lk(y,x) = sum(S_tilde((y-1)*L + 1 : y*L, (x-1)*L + 1 : x*L),'all')/L^2;
			if lk(y,x) > 0.85
				lk_bin(y,x) = 1;
			end
		end
	end
% 	imwrite(S_tilde, 'fig/S_tilde2.png');
% 	imwrite(S_backup, 'fig/S_tilde.png');
% 	figure(1)
% 	subplot 221
% 	image(I)
% 	colormap(gray(256)) %greyscale
% 	axis image
% 	subplot 222
% 	image(S, 'CDataMapping', 'scaled')
% 	colormap(gray(256)) %greyscale
% 	axis image
% 	subplot 223
% 	image(S_tilde, 'CDataMapping', 'scaled')
% 	colormap(gray(256)) %greyscale
% 	axis image
% 	subplot 224
% 	image(lk, 'CDataMapping', 'scaled')
% 	colormap(gray(256)) %greyscale
% 	axis image
% 	imwrite(S,'fig/S.png');
% 	imwrite(S_tilde,'fig/S_tilde.png');
	
end





