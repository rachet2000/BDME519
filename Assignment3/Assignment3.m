%x(t) = k*(rem(t,T) - T/2);

load edu519m3.mat
n_all = [1000,1000,1000,1000,1000,1000,100000,1000];
segments_all = [5,4,10,2,2,2,2,2];
x3 = x3(1:10000,:);
for i = 5
    
    S = x(3,1) - x(2,1);
    x_name = strcat('x', num2str(i));
    x = eval(x_name);
    
    n = n_all(i);
    f = fft(x(:,2), n);
    f = f(1:(length(f)/2));
    
    figure;
    subplot(3,2,1)
    plot(x(:,1), x(:,2))
    xlabel('Time')

    ylabel('Unit')
    title(strcat('Signal ', x_name))
    
    subplot(3,2,2)
    frequencies = (1:(n/2))*S/n;
    amplitude = abs(f);
    f0 = min(frequencies(amplitude > 0.1))
    
    
    
     plot((1:(n/2))*S/n, abs(f))
     
    xlabel('frequency (Hz)')
    ylabel('amplitude')
    title(strcat('Fast Fourier Transform of signal ', x_name))

    subplot(3,2,3)
    %Here you choose the length of each segment
    segment = segments_all(i);
    
    z1 = min(x(:,1)):S:((max(x(:,1))/segment));
    length(z1)
    z2 = mean(reshape(x(:,2),segment,[]))';
    length(z2)
    plot(z1, z2)
    xlabel('Time')
    ylabel('Unit')
    title(strcat('', x_name, 'average of ', num2str(segment), 'segments'))
    
    f2 = fft(reshape(x(:,2),segment,[])', n);
    
    subplot(3,2,4)
    plot(((1:n/2)*S/n/segment), abs(mean(f2(1:length(f2)/2, :)')'));
    xlabel('Frequency')
    ylabel('Amplitute')
    title(strcat('Mean fft for segments of', {' '}, x_name))
   
    subplot(3,2,5)
    plot(((1:n/2)*S/n/segment), mean(abs(f2(1:length(f2)/2, :)'))');
    xlabel('Frequency')
    ylabel('Amplitute')
    title(strcat('Average magnitude of fft: segments of', {' '}, x_name))
    
    subplot(3,2,6)
    periodogram(x(:,2))
    
   
end
   
    saveas(gcf, strcat('assignment3_signal', x_name, 'jpg'))
    
