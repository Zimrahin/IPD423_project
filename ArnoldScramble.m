function W_p = ArnoldScramble(W, p)
	if p == 0
		W_p = W;
		return
	end
	if p < 0
		error('p must be >= 0.');
	end
	L = size(W,1);
	%W_p = ones(size(W))*255;
	W_p = zeros(size(W))*255;
	for x = 1:L
		for y = 1:L
			x_s = ArnoldTransform(x, y, L);
			W_p(x_s(2), x_s(1)) = W(y,x);
		end
	end
	p = p - 1;
	
	if p < 1
		return
	else
		W_p = ArnoldScramble(W_p, p);
	end
end

function x_out = ArnoldTransform(x, y, L)
	% x_out:	(x', y')
	x_in = [x; y];
	x_in = x_in - 1;		% Arnold Transform is defined from 0
	%a = [1 2; 1 1];			% As defined in the paper
	a = [-1 2; 1 -1];			% Inverse of 'a' defined in the paper
% 	x_out = mod(a*x_in, L-1);	% For period 24
% 	x_out = x_out + 2;			% From 1 onwards
	x_out = mod(a*x_in, L);		% For period 64
	x_out = x_out + 1;			% From 1 onwards
end