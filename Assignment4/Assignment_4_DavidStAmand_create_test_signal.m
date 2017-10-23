%This part creates a test signal for part 1 of the assignment 

sampling_distance = 1;
sampling_end = 1000;
range_length = sampling_end/sampling_distance;
domain = zeros(1,range_length);



%freqs = 10.^(-5:0.001:5);
freqs = 0:0.1:1000;
%freqs = (8000)*rand(1, 30000 ,'double');
%freqs = freqs(freqs > 50); 

u = 0;
range = sampling_distance:sampling_distance:sampling_end;
for i = freqs
    u = u + 1 %#ok<NOPTS>
    domain = domain + sin(range.*i);
end

testsignal = [range;domain]';


%white_noise = [range;wgn(10000, 1)];


%flat = [range; ifft(ones(100000,1))']';


