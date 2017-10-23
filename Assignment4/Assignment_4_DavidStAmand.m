load edu519m4.mat
x_name = 'testsignal';
filt_name = 'filt5';
filt = eval(filt_name);
x = eval(x_name);
%S = 1/(x(3,1) - x(2,1));
f = fft(x(:,2));
%It's important to multiply by 2 when computing amplitudes
%DO NOT USE N IN FFT
amplitudes = abs(f(1:end/2)).*2;

T = max(x(:,1));
frequencies =  double(1:length(amplitudes))./double(T);


%figure;
%subplot(2,2,3)
%plot(frequencies, amplitudes)
%xlabel('Frequency (Hz)')
%ylabel('Amplitude')
%title(strcat('FFT of signal', {' '}, x_name))
%set(gca,'fontsize',23)
%subplot(2,2,4)
x_filt = [x(:,1) filterts(filt, x(:,2),2)];
f_filtered = fft(x_filt(:,2));
amplitudes_filtered = abs(f_filtered(1:end/2).*2);
%plot(frequencies, amplitudes_filtered)
%xlabel('Frequency (Hz)')
%ylabel('Amplitude')
%title(strcat('FFT of signal', {' '}, x_name, {' '}, 'with', {' '}, filt_name))
%set(gca,'fontsize',23)

%subplot(2,2,1)
%plot(x(:,1), x(:,2))
%xlabel('Time (s)')
%ylabel('Volt')
%title(strcat('Signal', {' '}, x_name))
%set(gca,'fontsize',23)

%subplot(2,2,2)
%plot(x_filt(:,1), x_filt(:,2))
%xlabel('Time (s)')
%ylabel('Volt')
%title(strcat('Signal', {' '}, x_name, {' '}, 'with', {' '}, filt_name))
%set(gca,'fontsize',23)


%use semilogx for bode plots
figure;
semilogx(frequencies.*1000, 20*log10(amplitudes_filtered./amplitudes));
xlabel('Frequency (Hz)')
ylabel('Gain (dB)')
title(strcat('Bode plot of', {' '}, filt_name))
set(gca,'fontsize',23)





