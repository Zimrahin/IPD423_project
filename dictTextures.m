function dict = dictTextures(W)
	L = size(W,1);
	P = computeP(W);
	dict = zeros(L,L,P);
	
	dict(:,:, 1) = ArnoldScramble(W, 1);
	
	for p = 2:P
		dict(:,:, p) = ArnoldScramble(dict(:,:, p-1), 1);
	end
end