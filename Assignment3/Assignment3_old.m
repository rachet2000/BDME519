%x(t) = k*(rem(t,T) - T/2);

load edu519m3.mat
n_all = [1000,1000,1000,1000,1000,1000,100000,1000];
segments_all = [5,4,5,2,2,2,2,2];
x3 = x3(1:10000,:);
for i = 1:8
    x_name = strcat('x', num2str(i));
    x = eval(x_name);
    n = n_all(i);
    f = fft(x(:,2), n);
    f = f(1:length(f)/2);
  
    figure;
    subplot(3,2,1)
    plot(x(:,1), x(:,2))
    xlabel('Time')

    ylabel('Unit')
    title(strcat('Signal ', x_name))
    
    subplot(3,2,2)
    plot(1:n/2, abs(f))
    xlabel('frequency')
    ylabel('amplitude')
    title(strcat('Fast Fourier Transform of signal ', x_name))

    subplot(3,2,3)
    segment = segments_all(i);
    
    plot(1:length(x)/segment, mean(reshape(x(:,2),segment,[]))')
    xlabel('Time')
    ylabel('Unit')
    title(strcat('', x_name, 'average of ', num2str(segment), 'segments'))
    
    f2 = fft(reshape(x(:,2),segment,[])', n);
    
    subplot(3,2,4)
    plot((1:n/2), abs(mean(f2(1:length(f2)/2, :)')'));
    xlabel('Frequency')
    ylabel('Amplitute')
    title(strcat('Mean fft for segments of', {' '}, x_name))
   
    subplot(3,2,5)
    plot(1:n, mean(abs(fft(reshape(x(:,2),segment,[])', n)'))');
    xlabel('Frequency')
    ylabel('Amplitute')
    title(strcat('Average magnitude of fft: segments of', {' '}, x_name))
    
    %subplot(3,2,6)
    %plot()
    
    figure;

     a = 1;
    for p = 1:length(x)/segment:length(x) - length(x)/segment + 1
        p
        subplot(3,3,a)
        plot(x(p:p +length(x)/segment -1 ,1), x(p: p+ length(x)/segment -1,2))
        xlabel('Frequency')
        ylabel('Units')
        title(strcat('segment', {' '}, num2str(a), {' '}, 'of signal', x_name))
        a = a + 1;
    end  
end
   
    saveas(gcf, strcat('assignment3_signal', x_name, 'jpg'))
    
