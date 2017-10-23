load edu519m2

means = [];
medians = [];
modes = [];
stds = [];
T = [means, medians, modes, stds];
x_all = [x1,x2,x3,x4,x5,x6,x7,x8,x9];
for i = 1:9
    x = x_all(:,i); 
    %plot_density(x,i)
    T(i,1) = mean(x);
    T(i,2) = median(x);
    T(i,3) = mode(x);
    T(i,4) = std(x);
    
end

plot_density(x10,10)
T(10,1) = mean(x10);
T(10,2) = median(x10);
T(10,3) = mode(x10);
T(10,4) = std(x10);

q1 = []; q2 = []; q3 = []; q4 = []; q5 = []; q6 = []; q7 = []; 
R = [q1,q2,q3,q4,q5,q6,q7];

for i = 1:9
    R(i,1) = mean(x_all(:,i) > T(i,1));
    R(i,2) = mean(x_all(:,i) > T(i,1) + T(i,4));
    R(i,3) = mean(x_all(:,i) < T(i,1) - T(i,4));
    R(i,4) = mean(T(i,1) - T(i,4) < x_all(:,i) & x_all(:,i) < T(i,1) + T(i,4));
    R(i,5) = mean(x_all(:,i) > T(i,1) + 2*T(i,4));
    R(i,6) = mean(x_all(:,i) < T(i,1) - 2*T(i,4));
    R(i,7) = mean(T(i,1) - 2*T(i,4) < x_all(:,i) & x_all(:,i) < T(i,1) + 2*T(i,4));
end
i = 10;
    R(10,1) = mean(x10 > T(10,1));
    R(10,2) = mean(x10 > T(i,1) + T(i,4));
    R(10,3) = mean(x10 < T(i,1) - T(i,4));
    R(10,4) = mean(T(i,1) - T(i,4) < x10 & x10 < T(i,1) + T(i,4));
    R(10,5) = mean(x10 > T(i,1) + 2*T(i,4));
    R(10,6) = mean(x10 < T(i,1) - 2*T(i,4));
    R(10,7) = mean(T(i,1) - 2*T(i,4) < x10 & x10 < T(i,1) + 2*T(i,4));

 xlswrite('part3',T);
 xlswrite('part4',R);
 
 %For part 4 x10
 std([(x10(x10 > 5) -5); (x10(x10 > 5) - 5)*-1])
 std([(x10(x10 < -5) +5); (x10(x10 < -5) + 5)*-1])
 s = 2.3;
 histogram([normrnd(5, s, [10000,1]); normrnd(-5, s, [10000,1])])
 
 
 %part 2
  eruptions = csvread('eruptions.csv');
   erupt = eruptions(:,1);
  plot(pdf(erupt, 20, 'freq'))
  plot(1:length(erupt), erupt)
  
  l = length(erupt);
  erupt_r = erupt(randperm(l));
  
  for bins = [10,20,40]
      for sample = [1,2,4]
          histogram(erupt_r(1:(l/sample)), bins)
          name = strcat('Eruptions with bins = ', num2str(bins), ' and sample = ', num2str(l/sample));
          title(name)
          xlabel('Time')
          ylabel('Frequency')
          saveas(gcf, strcat(name, '_density.jpg'))
      end
  end
  
  %part 3
  x3_artificial = sin((pi/250):(pi/250):(40*pi))';