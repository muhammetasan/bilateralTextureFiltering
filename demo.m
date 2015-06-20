filename ='fish.png';
I=imread(filename);
k=9;
c=size(I,3);
sigma_r=sqrt(c)*0.05;
sigma_d=k-1;
s=2*k-1;
isPar=0;
[guide,gprime]=calcGuidance(I,k,isPar);
r=I(:,:,1);
g=I(:,:,2);
b=I(:,:,3);
disp('Calculating R Channel');
r=BilateralFilter(r,gprime,sigma_d,sigma_r,s);
disp('Calculating G Channel');
g=BilateralFilter(g,gprime,sigma_d,sigma_r,s);
disp('Calculating B Channel');
b=BilateralFilter(b,gprime,sigma_d,sigma_r,s);
J=cat(3,r,g,b);


% 
% filename ='data/puzzle.jpg';
% I=imread(filename);
% I=imresize(I,0.25);
% for k=3:2:9
% c=size(I,3);
% sigma_r=sqrt(c)*0.05;
% sigma_d=k-1;
% s=2*k-1;
% isPar=0;
% [guide,gprime]=calcGuidance(I,k,isPar);
% r=I(:,:,1);
% g=I(:,:,2);
% b=I(:,:,3);
% disp('Calculating R Channel');
% r=BilateralFilter(r,gprime,sigma_d,sigma_r,s);
% disp('Calculating G Channel');
% g=BilateralFilter(g,gprime,sigma_d,sigma_r,s);
% disp('Calculating B Channel');
% b=BilateralFilter(b,gprime,sigma_d,sigma_r,s);
% J=cat(3,r,g,b);
% save([filename,'_test_',num2str(isPar),'_',num2str(k),'.mat'],'k','J','guide','gprime');
% end
% 
% filename ='data/gomlek.jpg';
% I=imread(filename);
% I=imresize(I,0.25);
% for k=3:2:9
% c=size(I,3);
% sigma_r=sqrt(c)*0.05;
% sigma_d=k-1;
% s=2*k-1;
% isPar=0;
% [guide,gprime]=calcGuidance(I,k,isPar);
% r=I(:,:,1);
% g=I(:,:,2);
% b=I(:,:,3);
% disp('Calculating R Channel');
% r=BilateralFilter(r,gprime,sigma_d,sigma_r,s);
% disp('Calculating G Channel');
% g=BilateralFilter(g,gprime,sigma_d,sigma_r,s);
% disp('Calculating B Channel');
% b=BilateralFilter(b,gprime,sigma_d,sigma_r,s);
% J=cat(3,r,g,b);
% save([filename,'_test_',num2str(isPar),'_',num2str(k),'.mat'],'k','J','guide','gprime');
% end
% system('shutdown -s');
