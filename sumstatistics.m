% NOTE: Isolated detection (ID) and Consistent detection (CD), label
% whether the stat is expected to have volatility in detecting isolated or
% consistent motion, LR AP SI are used in reference to image space

sum_stat = []

%ID & CD: total integral under both curves
x = find(final_movement2(1,1:24));
y = final_movement2(1,1:24);
first_aundercurve = trapz(x,y);
fprintf('%10s %d\n', "First: Total Area", first_aundercurve)

x = find(final_movement1(1,1:24));
y = final_movement1(1,1:24);
prev_aundercurve = trapz(x,y);
fprintf('%10s %d\n', "Prev: Total Area", prev_aundercurve)

sum_stat(1) = first_aundercurve;
sum_stat(2,1) = prev_aundercurve;


%ID & LR: returns values of integrals when comp to prev rep that are above
%the threshold, was able to do this due to an exponential progression in
%integral value

if prev_aundercurve > 10000
   fprintf('%10s %d\n', 'Property maps may have been obstructed by movement, area under the curve was', prev_aundercurve)
end

sum_stat(3,1) = prev_aundercurve;

%ID & LR: integral of area under the curve split into four parts compared to First
%rep
indexing = [ 6, 12, 18, 24];

for ii = 1:4
    if ii == 1
    x = find(final_movement2(1,1:6*ii));
    y = final_movement2(1,1:6*ii);
    area_undercurve(ii) = trapz(x,y);
    fprintf('%10s %d\n',"First: Area rep 1-6:",area_undercurve(1))
    
    end
    
    if ii > 1
        x = find(final_movement2(1,(6*(ii-1)):6*ii));
        y = final_movement2(1,6*(ii-1):6*ii);
        area_undercurve(ii) = trapz(x,y);
        fprintf('%10s %d\n',"First: Area rep",indexing(ii-1),'-',indexing(ii),':',area_undercurve(ii))
    end
  
    
end

sum_stat(4,1) = area_undercurve(1);
sum_stat(5,1) = area_undercurve(2);
sum_stat(6,1) = area_undercurve(3);
sum_stat(7,1) = area_undercurve(4);
%CD(where does more consistent movement occur) & AP: integral of area under the curve split into four parts compared to prev
%rep

indexing = [6, 12, 18, 24];

for ii = 1:4
    if ii == 1
    x = find(final_movement1(1,1:6*ii));
    y = final_movement1(1,1:6*ii);
    area_undercurve(ii) = trapz(x,y);
    fprintf('%10s %d\n',"Prev: Area rep 1-6:",area_undercurve(1))
    
    end
    if ii > 1
        x = find(final_movement1(1,(6*(ii-1)):6*ii));
        y = final_movement1(1,6*(ii-1):6*ii);
        area_undercurve(ii) = trapz(x,y);
        fprintf('%10s %d\n',"Prev: Area rep",indexing(ii-1),'-',indexing(ii),':',area_undercurve(ii))
    end
  
    
end

sum_stat(8,1) = area_undercurve(1);
sum_stat(9,1) = area_undercurve(2);
sum_stat(10,1) = area_undercurve(3);
sum_stat(11,1) = area_undercurve(4);


%ID & LR: Ratio of Maxiumum point to average, first rep (The higher the worse)

avg_movement2 = mean(final_movement2);
max_movement2 = max(final_movement2);
ratio_movement2 = max_movement2/avg_movement2;
fprintf('%10s %d\n', "First: Ratio of Max:Mean", ratio_movement2)
sum_stat(12,1) = ratio_movement2;

%CD & AP: Ratio of Maxiumum point to average prev rep (The higher the worse)

avg_movement1 = mean(final_movement1);
max_movement1 = max(final_movement1);
ratio_movement1 = max_movement1/avg_movement1;
fprintf('%10s %d\n', "Prev: Ratio of Max:Mean", ratio_movement1)

sum_stat(13,1) = ratio_movement1;

%CD & AP: Takes adjusted comp to prev rep set and produces a percentage of
%range which is comprised of non-outliers done for comp to prev rep due to
%the large number of extreme outliers

outlier_loc = isoutlier(final_movement1,'mean');

outlier = find(outlier_loc==1);
rem_outlier = final_movement1;
if outlier > 0
    for ii = 1:length(outlier)
        jj = outlier(ii);
        rem_outlier(jj) = '';
    end
end

adjusted_range = range(rem_outlier);

nonadjusted_range = range(final_movement1);

range_percent = round((adjusted_range/nonadjusted_range)*100);

fprintf('%10s %d\n', 'Prev: The adjusted range:', adjusted_range)
fprintf('%10s %d\n', 'Prev: The percentage of adjusted to non-adjusted range:', range_percent , '%')

sum_stat(14,1) = adjusted_range;
sum_stat(15,1) = range_percent;


%Will expose ID: mean adjusted for outliers comp to prev rep, will establish threshold
adjusted_mean = round(mean(rem_outlier),1);

nonadjusted_mean = mean(final_movement1);

mean_percent = round((adjusted_mean/nonadjusted_mean)*100);

fprintf('%10s %d\n', 'Prev: The adjusted mean:', adjusted_mean)
fprintf('%10s %d\n', 'Prev: The percentage of adjusted to non-adjusted mean:', mean_percent , '%')   

sum_stat(16,1) = adjusted_mean;
sum_stat(17,1) = mean_percent;


%CD & LR: mean ajusted for outliers compared to first rep, will establish threshold

outlier_loc = isoutlier(final_movement2,'mean');

outlier = find(outlier_loc==1);
first_rem_outlier = final_movement2;
if outlier > 0
    for ii = 1:length(outlier)
        jj = outlier(ii);
        first_rem_outlier(jj) = '';
    end
end

adjusted_mean = round(mean(first_rem_outlier),1);

nonadjusted_mean = mean(final_movement2);

mean_percent = round((adjusted_mean/nonadjusted_mean)*100);

fprintf('%10s %d\n', 'First: The adjusted mean:', adjusted_mean)
fprintf('%10s %d\n', 'First: The percentage of adjusted to non-adjusted mean:', mean_percent , '%') 

sum_stat(18,1) = adjusted_mean;
sum_stat(19,1) = mean_percent;

%AP & ID Whole curve divison to correct for isloated motion compt to prev

movement_divison = final_movement1./3000;
abnormal_reps = [];
for ii = 1:24
    if movement_divison(ii) >= 1
        abnormal_reps(ii) = ii;
    end
end          
        
colsWithZeros = any(abnormal_reps == 0, 1);
final_abreps = abnormal_reps(:, ~colsWithZeros);
fprintf('%10s %d\n', 'Prev: Isolated motion may have occured on rep:', final_abreps)


%ID & LR: returns values of all reps with Z score over 1.5 when compared to first
%rep
z_score = normalize(final_movement2);
first_unusualrep = [];

for ii = 1:24
    if z_score(ii) > 1.5
        first_unusualrep(ii) = ii;

    end
    
    
end
        
colsWithZeros = any(first_unusualrep == 0, 1);
final_first_unusualrep = first_unusualrep(:, ~colsWithZeros);
fprintf('%10s %d\n',"First: Reps with Z-score over 1.5:", final_first_unusualrep)



%ID & AP: returns values of all reps with Z score over 1.5 when compared to previous
%rep
z_score = normalize(final_movement1);
prev_unusualrep = [];

for ii = 1:24
    if z_score(ii) > 1.5
        prev_unusualrep(ii) = ii;

    end
    
    
end
        
colsWithZeros = any(prev_unusualrep == 0, 1);
final_prev_unusualrep = prev_unusualrep(:, ~colsWithZeros);
fprintf('%10s %d\n',"Prev: Reps with Z-score over 1.5:", final_prev_unusualrep)


metric_gui
  