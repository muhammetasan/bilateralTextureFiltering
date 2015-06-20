function [G,totVarQ]=calcPatchShift(Bq,totVarP,radius)
G=Bq;
[rows,cols]=size(Bq);
totVarQ=Inf(size(totVarP));
for y=radius+1:rows-radius
    for x=radius+1:cols-radius
        ymin=y-radius;
        xmin=x-radius;
        ymax=y+radius;
        xmax=x+radius;
        mask=zeros(size(Bq));
        mask(ymin:ymax,xmin:xmax)=1; % This mask tracks the window that is currently processed
        deltaCenter=totVarP(y,x); % Center tonal Range Value
        indexes=(totVarQ>deltaCenter)&mask>0; % Find Indexes that should be updated
        totVarQ(indexes)=deltaCenter; % Assign new Delta value
        G(indexes)=Bq(y,x);% Assign Bq to Gp
    end
    clc;
    disp(num2str(y));
end
end
