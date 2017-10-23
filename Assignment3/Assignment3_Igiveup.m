figure

for a = 1:5
x_name = 'x8';
x = eval(x_name);
S = x(3,1) - x(2,1);
N = 400;
subplot(3,2,a)
segment_length = 2000;

f = abs(fft(x(1 + segment_length*(a-1):segment_length*a -1,2), N));
plot((1:(N/2)) * S/N, f(1:end/2))
xlabel('Frequency', 'fontsize', 16)
ylabel('Amplitude', 'fontsize', 16)
title(strcat('FFT for segment', {' '}, num2str(a), {' '}, 'of', {' '}, x_name), 'fontsize', 18)
set(gca,'fontsize',17)
end