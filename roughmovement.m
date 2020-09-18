load('mask0p2_1.mat');
 mask1 = mask;

for kk = 2:24
    load(sprintf('mask0p2_%d.mat',kk));
    mask2 = mask;
    
    subtracted_mask = (double(mask1(:,:,25:45)>0)-double(mask2(:,:,25:45)>0));
    
    boolean_mask = (subtracted_mask>0);
    
    rough_sum0p35(kk) = sum(sum(sum(boolean_mask)));
    

end

figure_brainvoxel