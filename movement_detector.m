%Sums amount of pixels which exist in entire mask for each rep from slice
%25-45
for kk = 1:24
    load(sprintf('mask_%d.mat',kk));
    current_mask = mask;
    bool_mask = mask>0;
    bool_sum(kk) = sum(sum(sum(bool_mask(:,:,25:45))));
  
end

normal_bool = mean(abs(diff(bool_sum)));


%calculates rough movement in slices 25-45 by summing pixels which exist in
%mask of any repetition when compared to true value of mask 1. 
load('mask_1.mat');
 mask1 = mask;

for jj = 2:24
    load(sprintf('mask_%d.mat',jj));
    mask2 = mask;
    
    subtracted_mask = (double(mask2(:,:,25:45)>0)-double(mask1(:,:,25:45)>0));
    
    boolean_mask = (subtracted_mask>0);
    
    rough_sum(jj) = sum(sum(sum(boolean_mask)));
    

end

%normalizes data and sends to figure
final_movement2 = abs(rough_sum - normal_bool);

%figure_movementdetector

movement_detector1


