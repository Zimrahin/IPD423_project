function Delta_pthetak = computeOverallDissimilarity(W, b)
	% This is an implementation of equation (14)
	% First compute dissimilarity due to subband statistics
	L = size(W,1); % 64
	eta = computeEta(W,b);
	Delta_cpk = sqrt(sum(eta.^2, 'all')/L^2); % Equation (13)
	
	h_W = extractHOGFeatures(W,'CellSize', [64 64], 'BlockSize', [1 1], 'NumBins', 9);
	h_b = extractHOGFeatures(b,'CellSize', [64 64], 'BlockSize', [1 1], 'NumBins', 9);
	Delta_h = norm( h_W - h_b );
	
	gamma = 0.8; % As stated in the paper
	Delta_pthetak = ((Delta_h)^(1-gamma)) * (Delta_cpk^gamma);
end