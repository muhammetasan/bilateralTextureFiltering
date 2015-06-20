function [Guide,Gprime]=calcGuidance(I,k,isPar)
if(size(I,3)==3)
    I=rgb2gray(I);
end
radius=(k-1)/2; % k X k window radius
I=padarray(I,[radius,radius]); % Pad array once
averageImageB=calcAverage(I,k); %Ease of Read
oldTotVar=calcTotVar(averageImageB,radius); %oldTotVars will be used in calculating alpha
if(isPar==1)
    [Guide,newTotVars]=calcPatchShiftPar(averageImageB,oldTotVar,radius);
elseif isPar==0
    [Guide,newTotVars]=calcPatchShift(averageImageB,oldTotVar,radius);
end
sigmaAlpha = 5*k;
alpha=calcAlphas(oldTotVar,newTotVars,sigmaAlpha);
Gprime=double(alpha).*double(Guide)+double(1-alpha).*double(averageImageB);
Gprime=uint8(Gprime); %Gprime is G' of paper
Gprime=Gprime(radius+1:end-radius,radius+1:end-radius);
end