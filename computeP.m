function P = computeP(W)
	Wd = double(W);
	L = size(W,1);

	W_p = ArnoldScramble(Wd, 1);
	minDiff = sum((Wd-W_p).^2,'all');
	bestP = 1;
	
	for p = 2:3*L-1
		W_p = ArnoldScramble(W_p, 1);
		diff = sum((Wd-W_p).^2,'all');
		if diff < minDiff
			minDiff = diff;
			bestP = p;
		end
	end
	P = bestP;
end