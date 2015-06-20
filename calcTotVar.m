function mRTV=calcTotVar(I,radius)
mRTV=zeros(size(I));
disp('Calculating Modified TotalVariation');
tonalRange=calcTonalRange(I,radius);
[rows,cols]=size(I);
epsilon=10^(-9);
[Imag]=imgradient(I,'centralDifference'); % sqrt(x^2+y^2);
parfor y=radius+1:rows-radius
    for x=radius+1:cols-radius
    ymin=y-radius;
    ymax=y+radius;
    xmin=x-radius;
    xmax=x+radius;
    window=Imag(ymin:ymax,xmin:xmax); % window stores magnitudes of roi
    mRTV(y,x)=max(window(:)); % Max of Magnitudes
    mRTV(y,x)=mRTV(y,x)/(sum(window(:))+epsilon); % relative total Variation
    end
end
mRTV=mRTV.*tonalRange; % Multiply by DeltaP
end