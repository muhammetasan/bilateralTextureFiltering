function [ tonalRanges ] = calcTonalRange( I,radius )
% Calculate Delta of each window
disp('Calculating Tonal Ranges');
[rows,cols]=size(I);
tonalRanges=zeros(size(I));
parfor y=radius+1:rows-radius
    for x=radius+1:cols-radius
        ymin=y-radius;
        ymax=y+radius;
        xmin=x-radius;
        xmax=x+radius;
        roi=I(ymin:ymax,xmin:xmax);
        tonalRanges(y,x)=max(roi(:))-min(roi(:)); % Tonal Range = Max - Min of Window
    end
end
end

