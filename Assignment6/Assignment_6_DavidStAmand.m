
load edu519m6.mat
format long g
part = 2;
x_name = 'x10';
x = eval(x_name);
max_lag = 200;
%close all
increment = x(3,1) - x(2,1);

if part == 1
white_length = double(100000);
white_noise = normrnd(2,5, white_length, 1);
range = (1:white_length)';
c = mycorel(range, white_noise, min_lag, max_lag);
plot(min_lag:max_lag, c)
xlabel('Lag (s)')
ylabel('Correlation')
title('Auto correlation of white noise')
set(gca, 'fontsize', 23)
end

%autocorr(x(:,2), max_lag)
%xticklabels((0:max_lag/10:max_lag)' * increment)
%xlabel('Lag (s)')
%ylabel('Correlation')
%title(strcat('Sample auto-correlation coefficient function for', {' '}, x_name))
%set(gca, 'fontsize', 23)
%analysis(x, x_name)


if ismember(x_name, ['x1', 'x2', 'x3', 'x4', 'x5'])
ccor = xcorr(x(:,2) - mean(x(:,2)), max_lag, 'coef');
elseif ismember(x_name, ['x6', 'x7', 'x8', 'x9', 'x10'])
ccor = xcorr(x(:,3) - mean(x(:,3)), x(:,2) - mean(x(:,2)), max_lag,'coef');
subplot(2,2,1)
plot((-max_lag:max_lag)*increment, xcorr(x(:,2) - mean(x(:,2)), max_lag, 'coef'))
xlabel('Lag (s)')
ylabel('Correlation')
title(strcat(x_name, ':Input auto-correlation coefficients'))
%xticks(-5:5)
%xticklabels({'-5' '-4' '-3' '-2' '-1' '0' '1' '2' '3' '4' '5'})
set(gca, 'fontsize', 20)
xlim([-max_lag*increment max_lag*increment])
subplot(2,2,2)
plot((-max_lag:max_lag)*increment, xcorr(x(:,3) - mean(x(:,3)), max_lag, 'coef'))
xlabel('Lag (s)')
ylabel('Correlation')
title(strcat(x_name, ':Output auto-correlation coefficients'))
set(gca, 'fontsize', 20)
xlim([-max_lag*increment max_lag*increment])
%xticks(-5:5)
%xticklabels({'-5' '-4' '-3' '-2' '-1' '0' '1' '2' '3' '4' '5'})
subplot(2,2,3)

plot((-max_lag:max_lag)*increment, ccor)
xlabel('Lag (s)')
ylabel('Correlation')
title(strcat(x_name, ':Input/Output cross-correlation coefficients'))
set(gca, 'fontsize', 20)
xlim([-max_lag*increment max_lag*increment])
%xticks(-5:5)
%xticklabels({'-5' '-4' '-3' '-2' '-1' '0' '1' '2' '3' '4' '5'})
end
%plot((-max_lag:max_lag)*increment, ccor)
%xlabel('Lag (s)')
%ylabel('Correlation')
%title(strcat('Auto-correlation coefficient function for signal', {' '}, x_name))
%set(gca, 'fontsize', 18)

%plot(mycorel(x1(:,1), x1(:,2), -500, 500))
