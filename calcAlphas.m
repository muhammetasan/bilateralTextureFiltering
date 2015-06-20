function alphas=calcAlphas(mrtvP,mrtvQ,sigmaA)
disp('Calculating Alphas');
dif=mrtvP-mrtvQ;
dif=-dif*sigmaA;
dif=exp(dif);
dif=1+dif;
dif=dif.^(-1);
dif=dif-0.5;
alphas=2*dif;
end