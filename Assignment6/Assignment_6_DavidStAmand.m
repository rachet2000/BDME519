
load edu519m6.mat
format long g
part1 = 0;
x_name = 'x2';
x = eval(x_name);
max_lag = 500;
increment = x(3,1) - x(2,1);


if part1
white_length = double(10000);
white_noise = normrnd(2,5, white_length, 1);
range = (1:white_length)';
c = mycorel(range, white_noise, -500, 500);
figure;
plot(c)
xlabel('Time (s)')
ylabel('Volt')
title('Auto correlation of white noise')
end


autocorr(x(:,2), max_lag)
xticklabels((0:max_lag/10:max_lag)' * increment)

analysis(x, x_name)

