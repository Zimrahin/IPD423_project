function eta = computeEta(W, b)
	% This is an implementation of equation (12)
	% W and b are the same size
	cW = gaborDecomposition(W);
	cb = gaborDecomposition(b);
	L = size(W,1);
	
	numberOfSubbands = (L - 12)/4; % 12 = 0.75*16, 4 = 0.25*16
	eta = zeros(numberOfSubbands, numberOfSubbands);
	for iy = 1:numberOfSubbands
		yinf = 4*(iy-1)+1;
		ysup = yinf + 15;
		for ix = 1:numberOfSubbands
			xinf = 4*(ix-1)+1;
			xsup = xinf + 15;
			
			temp = 0;
			for s = 1:4
				for o = 1:4
					block_so_W = cW(s,o, yinf:ysup, xinf:xsup);
					block_so_W = reshape(block_so_W, 16, 16);				
					
					block_so_b = cb(s,o, yinf:ysup, xinf:xsup);
					block_so_b = reshape(block_so_b, 16, 16);
					
					deviationW = std(block_so_W,0,'all');
					deviationb = std(block_so_b,0,'all');
					
					skewnessW = skewness(block_so_W,1,'all');
					skewnessb = skewness(block_so_b,1,'all');
					
					kurtosisW = kurtosis(block_so_W,1,'all');
					kurtosisb = kurtosis(block_so_b,1,'all');

					temp = temp +   abs(deviationW-deviationb);
					temp = temp + 2*abs(skewnessW - skewnessb);
					temp = temp +   abs(kurtosisW - kurtosisb);
				end
			end
			eta(iy, ix) = temp;
		end
	end
end
