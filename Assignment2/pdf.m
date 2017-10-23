function [dist,dom] = pdf(x,numbins,option)
% compute the probabilty distibution of a signal
%	THE FUNCTION PDF COMPUTES THE PROBABILITY DISTRIBUTION FUNCTION
%	OF A GIVE CHANNEL X.
%
%	USAGE:	[dist,dom] = pdf(x,numbins,option)
%
%	x	: input vector
%	numbins: number of bins used in order to calculate the 
%		  discrete PDF or normalized histogram.
%	option  - string determined result
%                     'freq' - frequency histogram Ni
%                     'prob' - probabilty function Ni/Ntotal
%                     'dens' - proabilty density Ni/Ntotal*BinWidth
%
% EJP Jan 1991
% 1/10/93 REK Modified call to zeroes for MATLAB 4.1

% 19/10/93 TGR + DTW bug fixes -- binsum reset to 1 to include
%                frist point in new bin
%                save last binsum in dist(k)
%                now returns vector instead of matrix

% 21/10/93 TGR Ensure that roundoff errors in calculation of binwidth don't
%              cause more cells in dist than dom.
% REK 6 Oct 94 Added Frequency, Probabilty and Probabilty Density options

%
if (nargin==2),
  option='prob';
end
scale = length(x);
xs = sort(x);
mx = max(x);
mn = min(x);
binwidth = (mx - mn)/numbins;
dom=(mn + binwidth/2):binwidth:(mx - binwidth/2);
dommax = max(size(dom));
dist = zeros(size(dom));
k = 1;
binsum = 0;
for i=1:scale
	if xs(i) <= (mn + k*binwidth)
	   binsum = binsum + 1;
	else
	   dist(k) = binsum;
	   if ( k < dommax ) 
	       k = k+1;
	       binsum = 1;
	   end
	end 
end
dist(k) = binsum;
if (strcmp(option,'freq')),
  dist = dist;
elseif(strcmp(option,'prob')),
    dist = dist / scale;
elseif(strcmp(option,'dens')),
  dist = dist / (binwidth*scale);
else
  disp(['pdf - bad option:' option]);
  dist=[];
end
  