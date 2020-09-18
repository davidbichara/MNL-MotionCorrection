%Uses sumstatisics.m to create a metric and tag which gives an estimate of
%movement as well as where/what direction it occured

move_score = 0;
iso_score = 0;
consis_score = 0;

lower_bound = 0;
upper_bound = 0;

%integral compared to first rep threshold
if sum_stat(1) > 50000
    move_score = move_score + 1;
end

%integral compared to prev rep threshold
if sum_stat(2,1) > 10000
    move_score = move_score + 1;
end

%compares integral of sections of reps to full integral
index_count = [8 9 10 11];
index_string = [1 6 12 18 24];
average_area = sum_stat(2,1)/4;
for ii = 1:4
    if sum_stat(index_count(ii),1) > average_area
        lower_bound = index_string(ii);
        upper_bound = index_string(ii+1);
        if lower_bound ~= 0
            figure;
            p1 = plot(find(final_movement1), final_movement1, 'Color', 'red');
            hold on 
            p2 = plot(find(final_movement2), final_movement2, 'Color', 'Blue');
            hold off
            xlabel('Repetition', 'FontSize', 22);
            ylabel('Amount of Voxels Changed', 'FontSize', 22);
            axis([lower_bound upper_bound 0 9000]);
            p1.LineWidth = 7;
            p2.LineWidth = 7;
            set(gca,'YTick',0:1000:5000)
            set(gca,'fontsize', 18)
            ay = gca;
            ay.YRuler.Exponent = 0;
            lower_bound = 0;
            upper_bound = 0;
            x = input('Y/N: Does this set look irregular:', 's');
            if x == 'Y'
                move_score = move_score + 5;
            end
            if x == 'N'
                return
            end
        end
    end
end
        

%ratio of max-mean compared to first rep threshold
if sum_stat(12,1) > 2
    move_score = move_score + 1;
end


%adjusted/non-adjusted range compared to prev rep threshold
if sum_stat(15,1) < 70
    move_score = move_score + 1;
end

if sum_stat(15,1) < 50
    iso_score = iso_score +1; 
end


%adjusted/non-adjusted mean compared to prev rep threshold
if sum_stat(17,1) > 70 && sum_stat(17,1) < 87
    consis_score = consis_score +1;
    move_score = move_score + 1;
end

if sum_stat(17,1) <= 70
    move_score = move_score + 2;
    iso_score = iso_score +1;  
end



%adjusted/non-adjusted mean compared to first rep threshold
if sum_stat(19,1) < 90
    disp('AP movement may have occured')
    move_score = move_score + .5;
end

%establishing feeback thresholds for types of movement
if consis_score ~= 0
    disp("Consistent movement may have occured")
    iso_score = 0;
end


if iso_score ~= 0
    disp("Isolated movement may have occured")
end

%Activation functions for movement score

%move_metric = atan(move_score);

%e_move_metric = exp(move_score);
