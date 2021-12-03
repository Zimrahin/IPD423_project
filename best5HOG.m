function best5 = best5HOG(I, lk_bin, W, dictP)
	Pmax = size(dictP,3);
	L = size(W,1);
	% As specified in the paper, a single LxL rectangular
	% cell with nine histogram bins (20º per bin) and
	% L2 normalization is used.
	angles = [0 90 180 270];
	best5 = -ones(size(lk_bin,1), size(lk_bin,2), 10);		% -1 by default (for debugging)

	for x = 1:size(lk_bin,2)
		for y = 1:size(lk_bin,1)
			bk = I((y-1)*L + 1 : y*L, (x-1)*L + 1 : x*L);
			h_bk = extractHOGFeatures(bk,'CellSize', [L L], 'BlockSize', [1 1], 'NumBins', 9);

			if lk_bin(y,x) == 1			% Texture
				Delta_h = zeros(Pmax,4);	% p (1-Pmax), theta (0, 90, 180, 270)

				for p = 1:Pmax
					for theta = 1:4
						h_Wp = extractHOGFeatures(imrotate( dictP(:,:,p), angles(theta) ),'CellSize', [L L], 'BlockSize', [1 1], 'NumBins', 9);
						Delta_h(p, theta) = norm( h_bk - h_Wp );
					end
				end
				[~, indices] = mink(Delta_h(:),5);
				for index = 1:length(indices)
					best5(y,x, 2*index - 1) = mod(indices(index), Pmax);	% P
					%ang = angles( ( (indices(index)-1) - mod((indices(index)-1),Pmax) )/Pmax + 1 );
					ang = angles(ceil(indices(index)/Pmax));
					% For Pmax = 24 (example): index 1:24 -> angle 1
					% index 25:48 -> angle 2, index 49:72 -> angle 3
					% index 73:96 -> angle 4
					best5(y,x, 2*index) = ang;						% theta
				end

			else						% Not texture
				Delta_h = zeros(1,4);	% theta (0, 90, 180, 270)
				for theta = 1:4
					h_Wp = extractHOGFeatures(imrotate(dictP(:,:,Pmax), angles(theta)),'CellSize', [L L], 'BlockSize', [1 1], 'NumBins', 9);
					Delta_h(1, theta) = norm( h_bk - h_Wp );
				end
				[~, indices] = mink(Delta_h(:),5);
				for index = 1:length(indices)
					best5(y,x, 2*index - 1) = 0;		% P

					ang = angles(indices(index));
					best5(y,x, 2*index) = ang;			% theta
				end
			end
		end
	end
end