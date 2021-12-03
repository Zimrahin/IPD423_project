function subbands = block1616Decomposition(A)
% Function that takes any LxL image an decomposes it into 16x16
% blocks with 0.75% overlap  (L must be multiple of 4)
	L = size(A,1);
	numberOfSubbands = (L - 12)/4; % 12 = 0.75*16, 4 = 0.25*16
	subbands = zeros(numberOfSubbands^2, 16, 16);
	t = 1;
	for x = 1:numberOfSubbands
		for y = 1:numberOfSubbands
			yinf = 4*(y-1)+1;
			xinf = 4*(x-1)+1;
			subbands(t,:,:) = A(yinf:yinf+15, xinf:xinf+15);
			t = t + 1;
		end
	end
end