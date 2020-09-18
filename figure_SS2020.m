%creates bounds on axis
figure;
p1 = plot(find(final_movement1), final_movement1, 'Color', 'red');
hold on 
p2 = plot(find(final_movement2), final_movement2, 'Color', 'Blue');
hold off


xlabel('Repetition', 'FontSize', 22);
ylabel('Amount of Voxels Changed', 'FontSize', 22);

%sets bounds on axis
%axis([0 24 0 5000]);


%line width
 p1.LineWidth = 7;
 p2.LineWidth = 7;
 


%sets font size and rate at which y axis increases
set(gca,'YTick',0:1000:5000)
set(gca,'fontsize', 18)
 ay = gca;
ay.YRuler.Exponent = 0



%sumstatistics

%scrap code


%legend('Compared to previous Repetition','Compared to Repetition 1')

%title('Perceived movement per repetition', 'FontSize', 35);

%making of stiffness map figures

%figure;im(Mu(:,:,[28:29,36:37])); caxis([0 6]); colorbar; colormap(gca,stiff_color);

%print('-dpng',fig1)