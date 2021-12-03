% signal length
n = 63;
% number of spikes in the signal
k = 2;

%% DFT k sparse
c = zeros(n/2, 1);
q = randperm(n/2);
c(q(1:k/2)) = 1;

hamm = hamming(n);
hamm = hamm(n/2+1:n);
hamm = 10.^hamm;
c = c.*hamm;
c = c.*exp(1i.*rand(n/2,1).*2*pi);


c = [c; 0; conj(flipud(c(2:end)))];

x = ifft(c);
w = linspace(0,2,n);
%%
figure(1)
subplot 311
stem(abs(c), 'LineWidth', 1.2)
ylabel('Magnitude (-)')
xlabel('Normalised Frequency (\times\pi rad/sample)')
grid on
xlim([0 n]);
ylim([-1,11]);
subplot 312
stem(fftshift(abs(c)), 'LineWidth', 1.2)
ylabel('Phase (degrees)')
xlabel('Normalised Frequency (\times\pi rad/sample)')
grid on
xlim([0 n]);
ylim([-1,11]);
subplot 313
plot(x, 'LineWidth', 1.2)
grid on
xlim([0 n])
xlabel('Samples (-)')
set(gcf, 'Position',  [50, 50, 1500, 600]);