load edu519m6.mat
format long g
x_name = 'x2';
x = eval(x_name);
max_lag = 500;
increment = x(3,1) - x(2,1);



autocorr(x(:,2), max_lag)
xticklabels((0:max_lag/10:max_lag)' * increment)

analysis(x, x_name)