function G = logGaborTF(L, s, o)
	G		=	zeros(L,L);
	sigmas_rs=	1.1;
	r_s		=	2/3^s;		% Yields an approximately 1.5 octave spacing
	mu_o	=	(o-1)*pi/4;	
	sigma_o	=	pi/6;
	
	for u = -L/2:L/2 - 1	% L must be even
		for v = -L/2:L/2 - 1
			r = sqrt( (2*u/L)^2 + (2*v/L)^2 );
			theta = atan(v/u);
			G(v + L/2 + 1,u + L/2 + 1) = exp( -(log(r/r_s))^2 ./ (2*(log(sigmas_rs)^2)) );
			G(v + L/2 + 1,u + L/2 + 1) = G(v + L/2 + 1,u + L/2 + 1) .* exp( -(theta - mu_o)^2 / (2*sigma_o^2) );
		end
	end
end

% function G = logGaborTF(L, s, o)
% 	G		=	zeros(L,L);
% 	sigmas_rs=	1.1;
% 	r_s		=	2/3^s;		% Yields an approximately 1.5 octave spacing
% 	mu_o	=	(o-1)*pi/4;	
% 	sigma_o	=	pi/6;
% 	
% 	for u = 1:L
% 		for v = 1:L
% 			r = sqrt( (2*u/L)^2 + (2*v/L)^2 );
% 			theta = atan(v/u);
% 			G(v,u) = exp( -(log(r/r_s))^2 / (2*(log(sigmas_rs)^2)) );
% 			G(v,u) = G(v,u) * exp( -(theta - mu_o)^2 / (2*sigma_o^2) );
% 		end
% 	end
% end