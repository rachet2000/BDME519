function [] = analysis(x, x_name, column, bode)

f = fft(x(:,column));
amplitudes = abs(f(1:end/2)).*2;
T = max(x(:,1));
sampling_frequency = 1/(x(3,1) - x(2,1));
nyquist_frequency = sampling_frequency*0.5;
frequencies =  double(1:length(amplitudes))./double(T);

%figure;
%subplot(2,2,1);
%plot(x(:,1), x(:,2))
%title(strcat('Signal', {' '}, x_name))
%xlabel('Time (s)')
%ylabel('Volt')
%set(gca, 'fontsize', 23)

%subplot(2,1,2);
plot(frequencies, amplitudes)

title(strcat('FFT of signal', {' '}, x_name, {' '}))
xlabel('Frequency (Hz)')
ylabel('Amplitude')
set(gca, 'fontsize', 23)

if bode
f_out = fft(x(:,3));
amplitudes_out = abs(f_out(1:end/2)).*2;
frequencies_out = double(1:length(amplitudes))./double(T);
semilogx(frequencies.*1000, 20*log10(amplitudes_out./amplitudes));
xlabel('Frequency (Hz)')
ylabel('Gain (dB)')
title(strcat('Bode plot of system', {' '}, x_name))
set(gca,'fontsize',23)

end

end