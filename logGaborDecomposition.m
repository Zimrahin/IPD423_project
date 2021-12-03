function c = logGaborDecomposition(A)
	% Returns (s, o, L, L): 16 subbands (4 scales x 4 orientations)
	n = 4; % As described in the paper, 4 scales and orientations are used
	
	L = size(A,1); % A is a square matrix
	c = zeros(n,n, L,L);	
	
	for s = 1:n
		for o = 1:n
			G = logGaborTF(L, s, o);
			%temp = ifft2(G .* fft2(A));
			temp = ifft2(ifftshift(G) .* fft2(A));
			c(s,o, :,:) = abs(temp);
		end
	end	
end



