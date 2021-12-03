function return_img = read_minimiseDissimilarity(S)
	% Reads results of minimiseDissimilarity()
	% Returns image with each texture/rotation block
	N = size(S, 3);
	L = size(S, 1);
	return_img = zeros(L*N, L*N); % 512x512
	for y = 1:N
		for x = 1:N
			return_img((y-1)*L + 1 : y*L, (x-1)*L + 1 : x*L) = S(:,:,y,x);
		end
	end
end