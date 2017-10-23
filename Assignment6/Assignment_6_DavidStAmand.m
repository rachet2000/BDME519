white_length = double(10000);
white_noise = normrnd(2,5, white_length, 1);
range = (1:white_length)';
c = mycorel(range, white_noise, -500, 500);
plot(c)
xlabel('Time (s)')
ylabel('Volt')
title('Auto correlation of white noise')

load edu519m6.mat
autocorr(x1(:,2), 100)
%xticklabels((0:2:20)./(2))