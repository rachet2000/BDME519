function [] = plot_density(x,i)
    histogram(x)
    name = strcat('x',num2str(i));
    title(name)
    xlabel('Value')
    ylabel('Density')
    saveas(gcf, strcat(name, '_density.jpg'))
end




