function B=calcAverage(I,k)
disp('Calculating Averages');
h=fspecial('average',[k,k]);
B=imfilter(I,h);
end