
function [cor] = mycorel(x,y, min_lag, max_lag)
lags = min_lag:1:max_lag;
 cor = zeros(length(lags),1);
 m2 = mean(y)^2;
 v = var(y);
 for l = lags
 sum = 0;
 for a = x((1 - min_lag):max(x) - max_lag)'
 sum = sum + (y(a)*y(a + l));
 end
 cor(l - min_lag + 1) = (sum/length(y) - m2)/v;
 end
end