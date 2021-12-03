function return_var = minimiseDissimilarity(I, best5, dictP)
	% Returns best textures/rotation for each block
	L = 64;
	N = size(best5, 1); % 8
	
	return_var = zeros(L,L, N,N);
	for y = 1:N
		for x = 1:N
			b = I((y-1)*L + 1 : y*L, (x-1)*L + 1 : x*L);
			best_score = inf;
			best_match = zeros(L,L);
			for it = 1:5
				P = best5(y,x, 2*it-1);
				theta = best5(y,x, 2*it);
				if P ~= -1 
					if P == 0	% Non texture
						img_temp = dictP(:,:,end);
					else		% Texture
						img_temp = dictP(:,:,P);
					end
					img_temp = imrotate(img_temp, theta);
					score = computeOverallDissimilarity(img_temp, b);
					if score < best_score
						best_score = score;
						best_match = img_temp; % Best texture or rotation
					end
				end
			end
			return_var(:,:, y,x) = best_match;
		end
	end
 			
end