
figure;
x_name = 'x8';
x = eval(x_name);
x = x(:,:);
S = x(3,1) - x(2,1);
N = 400;
segment_length = 2000;
n_segments = length(x)/segment_length;


subplot(3,2,1)
plot(x(1:400, 1), x(1:400, 2))
xlabel('Time', 'fontsize', 16)
ylabel('Value')
title(strcat('Signal', {' '}, x_name), 'fontsize', 18)
set(gca,'fontsize',17)
f = fft(x(:,2), N);
subplot(3,2,2)
frequencies = (1:(N/2))*S/N;
    amplitude = abs(f(1:end/2));
    f0 = min(frequencies(amplitude > 300))
    fmax = max(frequencies(amplitude > 300))
    
    plot(frequencies, amplitude)
    xlabel('Frequency')
    ylabel('Amplitude')
    title(strcat('FFT of signal', {' '}, x_name), 'fontsize', 18)
    set(gca,'fontsize',17)
    
    subplot(3,2,3)
    w1 = (x(1:segment_length,1));
    w2 = reshape(x(:,2), [segment_length,n_segments])';
    
    plot(w1, mean(w2))
    xlabel('Time')
    ylabel('Value')
    title(strcat('Mean of segments of', {' '}, x_name), 'fontsize', 18)
    set(gca,'fontsize',17)
    subplot(3,2,4)
       temp_f = fft(w2', N);
    temp_f = temp_f(1:end/2, :);
    sub_amplitudes = abs(mean(temp_f'));
    plot(frequencies, sub_amplitudes(1:(N/2)))
    xlabel('Frequency')
    ylabel('Amplitude')
    title(strcat('Amplitude of mean fourier transforms: segments of', {' '}, x_name), 'fontsize', 17)
    set(gca,'fontsize',17)
    
    subplot(3,2,5)
    
    sub_amplitudes = mean(abs(temp_f'));
    plot(frequencies, sub_amplitudes(1:(N/2)))
    xlabel('Frequency')
    ylabel('Amplitude')
    title(strcat('Mean amplitude fourier transform: segments of', {' '}, x_name), 'fontsize', 18)
   set(gca,'fontsize',17)
    subplot(3,2,6)
    periodogram(x(:,2))
    
       set(gca,'fontsize',17)
    
    
