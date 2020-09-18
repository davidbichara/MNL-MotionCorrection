%movement when compared to last rep before it. 

for jj = 1:24
    load(sprintf('mask_%d.mat',jj));
    current_mask = mask;
    bool_mask = mask>0;
    bool_sum(jj) = sum(sum(sum(bool_mask(:,:,25:45))));
  
end

normal_bool = mean(abs(diff(bool_sum)));

load('mask_1.mat');
maskprevious = mask;

for kk = 2:24
    
load(sprintf('mask_%d.mat',kk));
mask2 = mask;
subtracted_mask =  (double(mask2(:,:,25:45)>0)-double(maskprevious(:,:,25:45)>0));
boolean_mask = subtracted_mask > 0;
rough_sum(kk) = sum(sum(sum(boolean_mask)));
maskprevious = mask2;


end 


final_movement1 = abs(rough_sum - normal_bool);

abs_zscore = abs(normalize(final_movement1));

%Creates list of reps which had a z-score above 1.96
for ii = 1:24
    if abs_zscore(ii) > 1.96
        %f = msgbox(sprintf('Rep %f is an outlier',ii));
        rep_outlier(ii) = ii;
  
    end
 
            
end



%figure_movementdetector

%figure_SS2020

sumstatistics
