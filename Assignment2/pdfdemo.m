function pdfdemo(option,option2,option3)
%  define a gui for recalling ankle data

global MOD3_FIG NUM_VAR DIST_NAME EST_NAME N_SAMP PLOT_FIG
NUM_VAR=5;
N_SAMP=1000;

if (nargin==0),
  option='init';
end
if nargin==1;
  option2=' ';
end

if strcmp(option,'init'),
  % {{{ Initialize
  MOD3_FIG=[];
  delete(get(0,'children'));
  MOD3_FIG=figure;

  % {{{ Figure dimensions
  fig_width=700;
  fig_height=500;
  border=2;
  frame_width=fig_width-2*border;
  text_width_max = frame_width - 20;
  x_center = fig_width/2;
  ss=get(0,'screensize');
  set (MOD3_FIG,'Position',[ss(3)-fig_width-25 ss(4)-fig_height-25 fig_width fig_height]);
  width = 50;
  w2 = 100;
  height = 20;
  delx=10;
  dely =  height+ 10;
  x1=5;
  x2 = x1+width+10;
  x3 = x2+delx+width;
  x4 = x3+delx+width;
  x5 = x4+delx+width;
  x6 = x5+delx+width;
  x7 = x6+delx+width;
  x8 = x7+delx+width;

  ypos = fig_height-25;
  active_color=[ 0 1 0];
  passive_color = [.6 .6 .6];
  set (gca,'visible','off','position',[0 0 1 1], ...
    'units','pixels');
% }}}
h_dist = uicontrol (MOD3_FIG, ...
    'value',1, 'style','popup', ...
        'back', active_color, ...
    'pos',[x1 ypos 2*width height], ...
    'horizontalalign','left',...
    'string',[ 'normal|rectangular|chi-square|F-distribution|student-t' ...
    '|log-normal|exponential|binomial|Poisson' ], ...
    'callback','pdfdemo(''popup'')');
ypos=ypos-dely;
var_name= uicontrol(MOD3_FIG, 'style','text', ...
    'back',[0 0 1], ...
    'Pos',[ x1  ypos+5 2*width height],'string','Distribution',...
    'horizontal','center');
ypos=ypos-dely;

h_est = uicontrol (MOD3_FIG, ...
    'style','popup', ...
            'back', active_color, ...
    'pos',[x1  ypos  2*width height], ...
    'string', 'Frequency|Probabilty|Density', ...
    'value',3, 'callback','pdfdemo(''est-popup'')');
ypos=ypos-dely;
var_name= uicontrol(MOD3_FIG, 'style','text', ...
    'back',[0 0 1], ...
    'Pos',[ x1  ypos+5 2*width height],'string','Estimate',...
    'horizontal','center');
EST_NAME='dens';

axl=.30;
axw=.6;
axh=.2;
axy=.1;
for i=1:3,
   h_axis(i)= axes ('Position', [ axl axy axw axh]);
axy = axy+axh+.1;
end

for i=1:NUM_VAR,

    % {{{ Variable sliders and entry points 

  ypos = ypos - dely;

slider_width = 50;
slider_height = height/2;

var_frame_w = slider_width + 2*border;
var_frame_h = slider_height+ height + 3*border;
var_frame_x = x1- border ;
var_frame_y = ypos - var_frame_h - border;

var_slider_x = x1+border;
var_slider_y = var_frame_y + border;

var_frame= uicontrol (MOD3_FIG, ...
    'Style', 'frame' , ...
    'Pos', [ var_frame_x var_frame_y var_frame_w var_frame_h ], ...
    'visible','off');


var_val = uicontrol (MOD3_FIG, ...
    'Style', 'edit', ...
    'Pos',[ 10+width/2  ypos width height], ...
    'back', active_color, ...
    'String',int2str(1), ...
    'Horizontal','center', ...
    'Callback',[ 'pdfdemo(''val'',' int2str(i) ')'] );

var_name= uicontrol(MOD3_FIG, 'style','text', ...
    'back', [ 0 0 1], ...
    'Pos',[ 10  ypos-25 2*width height],'string','Name',...
    'horizontal','center');

ypos = var_frame_y;

% }}}
    h_var_frame(i)=var_frame;
    h_var_name(i)=var_name;
    h_var_val(i)=var_val;
  end

  % {{{  Save handles
  h=[h_var_frame  h_var_name  h_var_val ];
  i=3*NUM_VAR;
  h(i+1)=h_dist;
  h(i+2)=h_est;
  h=[h h_axis];
  set(MOD3_FIG, 'UserData',h);
% }}}
  pdfdemo('popup');
  return

% }}}


else
% {{{  Recall handles
  h=get (MOD3_FIG, 'Userdata');
  h1 = h(1:3*NUM_VAR);
  h1=reshape(h1,NUM_VAR,3);
  h_var_frame=h1(:,1);
  h_var_name=h1(:,2);
  h_var_val=h1(:,3);
  i=3*NUM_VAR;
  h_dist=h(i+1);
  h_est=h(i+2);
  h_axis=h(i+3:i+5);
      % }}}
  
  if (strcmp(option,'var-disp')),
    for i=1:length(option2),

      set (h_var_val(option2(i)),'visible',option3);
      set (h_var_name(option2(i)),'visible',option3);
    end
    return
  elseif (strcmp(option,'val')),
      xval=' ';
      
    xval=inputd1 (h_var_val(option2), xval);
  elseif (strcmp(option,'est-popup')),
    s1=get(h_est,'string');
    v1=get(h_est,'val');
    EST_NAME=deblank(s1(v1,:));
    EST_NAME=lower(EST_NAME(1:4));
  elseif (strcmp(option,'popup')),
    % {{{ Determine distribution and set parameters
    v1=get(h_dist,'val');
    s1=get(h_dist,'string');
    DIST_NAME=deblank(s1(v1,:));

    set (h_var_name(1),'string','N SAMP');
    set (h_var_val(1),'string','1000');
    set (h_var_name(2),'string','N BIN');
    set (h_var_val(2),'string','25');
    
    % }}}
    if (strcmp(DIST_NAME,'normal')),
      % {{{ Normal setup 

      x1=0;
      x1_min=-100;
      x1_max=100;
      x2=10;
      set (h_var_name(3),'string','Mean');
      set (h_var_name(4),'string','Std. Dev.');
      set (h_var_val(4),'string',num2str(x1));
      set (h_var_val(4),'string',num2str(x2));
      pdfdemo('var-disp',4,'on');
      pdfdemo('var-disp',4,'on');
      pdfdemo('var-disp',5,'off');
% }}}
    elseif (strcmp(DIST_NAME,'rectangular')),
      % {{{ Rectangular

      x1=0;
      x2=1;
      x1_min=-100;
      x1_max=100;
      set (h_var_name(3),'string','Min');
      set (h_var_name(4),'string','Range');
      set (h_var_val(3),'string',num2str(x1));
      set (h_var_val(4),'string',num2str(x2));
      pdfdemo('var-disp',4,'on');
      pdfdemo('var-disp',5,'off');
% }}}
    elseif (strcmp(DIST_NAME,'F-distribution')),
      % {{{ F-distribution

      x1=5;
      x2=5;
      x1_min=2;
      x1_max=100;
      set (h_var_name(3),'string','DOF (m)');
      set (h_var_name(4),'string','DOF (n)');
      set (h_var_val(3),'string',num2str(x1));
      set (h_var_val(4),'string',num2str(x2));
      pdfdemo('var-disp',4,'on');
      pdfdemo('var-disp',5,'off');
      
      % }}}
    elseif(strcmp(DIST_NAME,'exponential')),
      % {{{ exponential
      x1=5;
      x1_min=0;
      x1_max=100;
      set (h_var_name(3),'string','mean');
      set (h_var_val(3),'string',num2str(x1));
      pdfdemo('var-disp',4,'off');
      pdfdemo('var-disp',5,'off');
      % }}} 
    elseif (strcmp(DIST_NAME,'chi-square') | strcmp(DIST_NAME,'student-t')),
      % {{{ Chi-square or student-t

      x1=3;
      x1_min=1;
      x1_max=100;
      set (h_var_name(3),'string','DOF');
      set (h_var_val(3),'string',num2str(x1));
      pdfdemo('var-disp',[4 5],'off');
% }}}
    elseif(strcmp(DIST_NAME,'discrete-rectangular')),
      % {{{ discrete-rectangular
     x1=5;
      x1_min=0;
      x1_max=100;
      set (h_var_name(3),'string','N Out');
      set (h_var_val(3),'string',num2str(x1));
      pdfdemo('var-disp',4,'off');
      pdfdemo('var-disp',5,'off');

      % }}}  
    elseif(strcmp(DIST_NAME,'binomial')),
      % {{{ binomial

      x1=.1;
      x2=5;
      x1_min=0;
      x1_max=1;
      
      set (h_var_name(3),'string','N Trial');
      set (h_var_val(3),'string',num2str(x2));

      set (h_var_name(4),'string','Prob');
      set (h_var_val(4),'string',num2str(x1));
      
      pdfdemo('var-disp',4,'on');
      pdfdemo('var-disp',5,'off');
      % }}}  
    elseif(strcmp(DIST_NAME,'Poisson')),
      % {{{ Poisson
      x1=5;
      x1_min=0;
      x1_max=100;
      set (h_var_name(3),'string','mean');
      set (h_var_val(3),'string',num2str(x1));
      pdfdemo('var-disp',[4 5],'off');
      % }}} 
    elseif (strcmp(DIST_NAME,'log-normal')),
      % {{{ F-distribution

      x1=5;
      x2=5;
      x1_min=0;
      x1_max=100;
      set (h_var_name(3),'string','mean');
      set (h_var_name(4),'string','variance');
      set (h_var_name(5),'string','offset');
      set (h_var_val(3),'string',num2str(x1));
      set (h_var_val(4),'string',num2str(x2));      
      set (h_var_val(5),'string',num2str(x2));      
      pdfdemo('var-disp',[4 5],'on');

% }}}
    else
      disp(['pdfdemo Bad distribution:' DIST_NAME '!'])
    end
  else
    disp('bad option')
  end
  N_SAMP=inputd1(h_var_val(1));
  N_BIN=inputd1(h_var_val(2));
  X1=inputd1(h_var_val(3));
    X2=inputd1(h_var_val(4));
    X3=inputd1(h_var_val(5));
    
      
  % {{{ Generate  deviates and plot
    if strcmp(DIST_NAME,'rectangular'),
      X2=X1+X2;
    end
    x=randev(DIST_NAME, N_SAMP, X1, X2, X3 );

   % plot deviates  here
   if (~ isempty(x)),
     axes(h_axis(1));
     plot (x)
     title('Deviates');
     ylabel('Range');
     xlabel('Sample number');
     axes(h_axis(2));
     nbin=10;
     [nh,xh]=pdf(x,N_BIN,EST_NAME);
     bar (xh,nh);
     title('Estimated PDF');

     ylabel('Prob');
   end

% }}}	
  % {{{ Plot PDF

xmin = min(x);
xmax=max(x);
y=linspace(min(x),max(x),N_BIN);

axes (h_axis(3))
if (strcmp(DIST_NAME,'binomial')),
  y=unique(round(y));
  f=ranpdf(DIST_NAME,y,X1,X2,X3);
  stem(y,f);
else
  f=ranpdf(DIST_NAME,y,X1,X2,X3);
  plot (y,f,'o',y,f,'-');
end

ylabel('Prob');
title('Theoretical PDF');
% }}}
end
% {{{ Emacs local variables

% Local variables:
% folded-file: t
% end;

% }}}




function val = inputd1 ( handle,default,xmin,xmax)
% decode a  string with default values and option range checking
%

if (nargin < 4),
	xmax = 1.e20;
end
if (nargin < 3),
	xmin = -1e20;
end
if nargin < 2,
	x = 0;
else
	x = default;
end
done = 0;
	temp = str2num(get(handle,'string'));                         
	if isempty (temp),
		val = x;
		done = 1;
	else
		if (temp > xmax),
			disp('input_d1: Value to large. Setting to max');
			set(handle,'String',num2str(xmax));
			val =xmax;
		elseif (temp < xmin),
		  	disp('input_d1: Value too small. Setting to min');
			set(handle,'String',num2str(xmin));
			val =xmin;
		else
			val = temp;
			done = 1;
		end
	end


function x = randev(dist, dim, p1,p2,p3)
% Generates deviates for various  proability densities
%
% usage:
%          x = randev (dist, n, p1, p2, p3 )
%
% where
%     n is the dimension of the array to generate.
%     the other parameters are used as follows:
%
%         dist              p1       p2            p3     
%
%       'normal',            mean     standard deviation 
%       'chi-square',        dof
%       'student-t',         dof
%       'F-distribution'     dof1     dof2
%       'log-normal',        mean     standard_Deviation    offset  
%       'rectangular',       xmin     xmax
%       'exponential',       mean
%    'discrete-rectangular'  imin     imax
%       'binomial',          n        probabilty
%       'Poisson'            mean 
%
%deviates from different  distributions
% 28 Nov 97 REK Fix parameter values for log-normal.


% {{{ Parse input and check validity



if (length(dim) ==1),

  n = 1 ;

  m = dim(1);

elseif (length(dim)==2),

  m = dim(1);

  n = dim(2);

else,

  disp('ERROR - output array must be of dimension 1 or 2')

  x=NaN;

  return

end



% }}}



% {{{ normal



if (strcmp(dist,'normal')),

  mu=p1;

  sd=p2;

  x=(mu + sd*randn(m,n));



% }}}

% {{{ discrete-rectangular



elseif (strcmp(dist,'discrete-rectangular')),

  xmin = p1-1;

  xmax = p2;

  x=xmin +(xmax-xmin)*rand(m,n);

  x=ceil(x);



% }}}

% {{{ rectangular



elseif (strcmp(dist,'rectangular')),

  xmin = p1;

  xmax = p2;

  x=xmin +(xmax-xmin)*rand(m,n);



% }}}

% {{{ chi-square deviates



elseif (strcmp(dist,'chi-square')),

  dof=p1;

  x=randn(dof,m*n);

  if (dof == 1),
    x=x.^2;
  else
   x= sum(x.^2);
  end
  x=reshape(x,m,n);



% }}}

% {{{ student-t deviates



elseif (strcmp(dist,'student-t')),

  dof = p1;

  x1 = randn(m,n);



  % x2 - chi-square deviates

  

  x2=randn(dof,m*n);

  x2=sum(x2.^2);

  x2=reshape(x2,m,n);



  % gnerate t-distribution deviates

  

  x= sqrt(dof) * ( x1 ./ sqrt(x2));

  



% }}}

% {{{ F-deviates



elseif (strcmp(dist,'F-distribution')),



   % {{{  parse input and check validity



  %

  if (nargin < 4),

    disp('ERROR: random_pdf  not enough parameters specified');

    disp('Usage is: x = random_pdf(''F-distribution'',n,dof1,dof2');

    x=NaN

    return

  end

  if (p1<=1) | (p2<=1),

    disp('ERROR: Both values for degrees-of-freedom must be > 1');

    x=NaN;

    return

    end



% }}}

   % {{{ Generate F-distribution deviates



  dof1 = p1;

  dof2 = p2;

  %

  % x1 - chi-square deviate with dof1 degrees of freedom

  %

  x1=randn(dof2,m*n);

  x1=sum(x1.^2);

  x1=reshape(x1,m,n);



  %

  %x2 - chi-square deviate with dof2 degrees of freedom

  %

  x2=randn(dof1,m*n);

  x2=sum(x2.^2);

  x2=reshape(x2,m,n);



  %

  % generate deviates

  

  x= (x1/dof1) ./ (x2/dof2);



% }}}



% }}}

% {{{ exponential deviates



elseif (strcmp(dist,'exponential')),

  mu=p1;

  x=rand(m,n);

  y=x(:);

  while (any(y==0)),

    i=find(y==0);

    y(i)=rand(i,1);

  end

  x=-mu*log(y);

  x=reshape(x,m,n);



% }}}

% {{{ log-normal deviates



else if (strcmp(dist,'log-normal')),

  mu = p1;

  var=p2;

  offset=p3;

  z=mu + var*randn(m,n);

  x= exp(z) + offset;

  



% }}}

% {{{ Binomial deviates

elseif (strcmp(dist,'binomial')),

% 

% {{{  parse input and check its validity

  if (nargin <4),

    disp('ERROR: random_pdf  not enough parameters specified');

    disp('Usage is: f = randevxb(''binomial'',n,number-of-event,probability');

    x=NaN

    return

  end



% }}}

prob=p2;

  ntrial=p1;

  x=zeros(m,n);

  for i=1:ntrial,

    xt=rand(m,n);

    j=find(xt < prob);

    x(j)=x(j)+1;

  end



% }}}

% {{{ Poisson deviates



elseif (strcmp(dist,'Poisson')),

  mu=p1;

  count = zeros(m,n);

  xt = ones (m,n);

  xlimit = exp(-mu);



  done =0;

  while ~ done,

    xt= xt .* randn (m,n);

    i = find (xt > xlimit);

    if isempty(i),

      done=1;

    else,

      count(i)=count(i)+1;

    end

  end

  x=count;



% }}}





else

  disp('distribution not available')

end

end





% {{{ Emacs local variables



% Local variables:

% folded-file: t

% end;



% }}}



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


