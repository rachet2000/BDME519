x = x10
for i = 1:10
   plot(x(:,i)-i*max((max(x(:,:))) - min(min(x(:,:))))) 
   hold on
    
end
hold off
