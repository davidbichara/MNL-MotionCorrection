%allows experimentation with extraction thresholds 7/3/20
%load ep2d imgraw
imgraw2 = zeros([120 120 48 24]);
imgraw2(:,:,:,:) = abs(reshape(imgraw,[120 120 48 24]));


for ii=1:24
imgrawn2= load_nii('t2stack.nii');
imgrawn2 = make_nii(imgraw2(:,:,:,ii),[2.5 2.5 2.5]);  
mkdir(sprintf('rep_%d',ii))
cd(sprintf('rep_%d',ii))
save_nii(imgrawn2,'imgraw_data.nii');

%output file name before -m
!/usr/local/fsl/bin/bet2 imgraw_data.nii imgraw_mask.nii -m -v -f 0.2 -w 1.3
!gunzip -f *.nii.gz

mask = load_nii('imgraw_mask.nii')
mask = mask.img;
cd ..
save(sprintf('mask_%d',ii),'mask');
end



%-f is the weighting 
!gunzip -f *.nii.gz
