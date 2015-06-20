%THIS IS PARALLEL IMPLEMENTATION OF CALCGUIDE
function [G,totVarQ]=calcPatchShiftPar(Bq,totVarP,radius)
[rows,cols]=size(Bq);
G=Bq;
disp('Calculating G');
totVarQ=zeros(size(totVarP));
parfor y=radius+1:rows-radius
    for x=radius+1:cols-radius
    window=totVarP(y-radius:y+radius,x-radius:x+radius);
    [~,index]=min(window(:));
    [yy,xx]=ind2sub([size(window,1),size(window,2)],index);
    pos=[y-radius-1,x-radius-1];
    pos=pos+[yy,xx];
    G(y,x)=Bq(pos(1),pos(2));
    totVarQ(y,x)=totVarP(pos(1),pos(2));
    end
end