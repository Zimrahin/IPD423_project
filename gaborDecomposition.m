function c = gaborDecomposition(A)
	% Returns (s, o, L, L): 16 subbands (4 scales x 4 orientations)
	n = 4; % As described in the paper, 4 scales and orientations are used
	
	L = size(A,1); % A is a square matrix
	c = zeros(n,n, L,L);
	
	scales = [2,4,8,16];
	orientations = [0, 45, 90, 135]; %degrees	
	
	for s = 1:n
		for o = 1:n
			[mag,~] = imgaborfilt(A,scales(s),orientations(o));
			c(s,o, :,:) = mag;
		end
	end	
end