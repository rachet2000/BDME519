load edu519m5.mat

i = 10;
%for i = 1:5
x_name = strcat('x', num2str(i));
x = eval(x_name);
f = fft(x(:,2));
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

%subplot(2,2,2);
plot(frequencies, amplitudes)

%title(strcat('FFT of signal', {' '}, x_name, {' '}, ', which has a sampling frequency of', {' '}, num2str(sampling_frequency), {' '}, 'Hz'))
%xlabel('Frequency (Hz)')
%ylabel('Amplitude')
%set(gca, 'fontsize', 23)

%end
figure;
subplot(2,1,1)
histogram(x(:,2), 100)
title(strcat('Estimated probability density function from signal', {' '}, x_name))
xlabel('Volt')
ylabel('Density')

subplot(2,1,2)
plot(0.01:0.01:1.29, mean(periodogram(reshape(x(:,2),[100,40]))'))
xlabel('Normalized frequency')
ylabel('Power/Frequency')
title(strcat('Mean of periodogram of signal', {' '}, x_name))


