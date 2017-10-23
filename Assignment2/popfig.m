function [fig_out, status] = popfig (fig_in )
% pop a figure, creating a new onne  if necessary
%
if (length(fig_in>0)) &  (any(get(0,'children')== fig_in))
  fig_out =  figure(fig_in) ;
  status='old';
else
  fig_out = figure;
  status = 'new';
end
    