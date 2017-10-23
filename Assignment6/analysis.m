function [] = analysis(x, x_name)

f = fft(x(:,2));
amplitudes = abs(f(1:end/2)).*2;
T = max(x(:,1));
sampling_frequency = 1/(x(3,1) - x(2,1));
nyquist_frequency = sampling_frequency*0.5;
frequencies =  double(1:length(amplitudes))./double(T);

figure;
subplot(2,2,1);
plot(x(:,1), x(:,2))
title(strcat('Signal', {' '}, x_name))
xlabel('Time (s)')
ylabel('Volt')
set(gca, 'fontsize', 23)

subplot(2,2,2);
plot(frequencies, amplitudes)

title(strcat('FFT of signal', {' '}, x_name, {' '}))
xlabel('Frequency (Hz)')
ylabel('Amplitude')
set(gca, 'fontsize', 23)

end