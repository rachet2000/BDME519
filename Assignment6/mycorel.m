
function [cor] = mycorel(x,y, min_lag, max_lag)
lags = min_lag:max_lag;
 cor = zeros(length(lags),1);
 m = mean(y);
 m2 = m^2;
 v = var(y);

 for lag = lags
 sum = 0;
 if lag >= 0
 this = (1:(length(x) - lag));
 end
 if lag < 0
 this = (1 - lag:length(x));
 %this = x((1 - min_lag):max(x) - max_lag)';
 end
 %this = x((1 - min_lag):max(x) - max_lag)';
 for a = this
 sum = sum + (y(a)*y(a + lag));
 end
 cor(lag - min_lag + 1) = (sum/length(this) - m2)/v;
 end
end