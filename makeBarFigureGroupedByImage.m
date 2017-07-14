function makeBarFigureGroupedByImage(data,yLab)

users={'User 1' 'User 2' 'User 3' 'User 4' 'User 5' 'User 6'};

axes1 = axes('Parent',gcf);
bar1 = bar(data','Parent',axes1);
set(bar1(1),'FaceColor',[1 0 0], 'DisplayName','QuRVA');


for it=2:size(data, 1)
    set(bar1(it),'FaceColor',[0 2/9+it*1/9 0], 'DisplayName',users{it-1});
end

for it=1:size(data, 2)
    xEtiquetas{it}=['Image ' num2str(it)];
end

set(axes1,'FontSize',14,'XTick',[1 2 3 4 5 6 7 8 9 10 11 12 13 14],...
    'XTickLabel', xEtiquetas, 'XTickLabelRotation',45);

ylabel(yLab);

hold on
errorbar(1:14,10*ones(1,14),'ok')