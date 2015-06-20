function J=BilateralFilter(I,G,sigma_d,sigma_r,filterSize)

filterRadius=ceil((filterSize-1)/2);
I=double(I)/255;
G=double(G)/255;
I=padarray(I,[filterRadius,filterRadius],'replicate');
G=padarray(G,[filterRadius,filterRadius],'replicate');
if( size(I,3)==1)
    J=bftGrayImage(I,G,sigma_d,sigma_r,filterRadius);
elseif (size(I,3)==3)
    J=btfColorImage(I,G,sigma_d,sigma_r,filterRadius);
end
end

function J=bftGrayImage(I,G,sigma_d,sigma_r,filterRadius)
x=-filterRadius:filterRadius;
y=-filterRadius:filterRadius;
J=zeros(size(I));
[xx,yy]=meshgrid(x,y);
spatialCoeffs=exp(- (xx.^2+yy.^2)/(2*sigma_d^2));
[rows,cols]=size(I);
parfor y=filterRadius+1:rows-filterRadius
    for x=filterRadius+1:cols-filterRadius
        roi= I(y-filterRadius:y+filterRadius,x-filterRadius:x+filterRadius);
        centerValue=G(y,x);
        roidif=roi-centerValue;
        tonalWeight =exp(- roidif.^2/(2*sigma_r^2));
        F=(tonalWeight.*spatialCoeffs);
        k=sum(F(:));
        weight=F.*roi;
        J(y,x)=sum(weight(:))/k;
    end
end
J=mat2gray(J);
J=J(filterRadius+1:end-filterRadius,filterRadius+1:end-filterRadius);
end

function J=btfColorImage(I,G,sigma_d,sigma_r,filterRadius)
x=-filterRadius:filterRadius;
y=-filterRadius:filterRadius;
[xx,yy]=meshgrid(x,y);
spatialKernel=exp(- (xx.^2+yy.^2)/(2*sigma_d^2));
[rows,cols,channels]=size(I);
rc=zeros(size(I(:,:,1)));
gc=zeros(size(rc));
bc=zeros(size(gc));
if size(G,3)==1
    temp=G;
    G(:,:,1)=temp;
    G(:,:,2)=temp;
    G(:,:,3)=temp;
end

parfor y=filterRadius+1:rows-filterRadius
    for x=filterRadius+1:cols-filterRadius
        roi= I(y-filterRadius:y+filterRadius,x-filterRadius:x+filterRadius,:);
        roidif=zeros(size(roi));
        roidif(:,:,1)=roi(:,:,1)-G(y,x,1);
        roidif(:,:,2)=roi(:,:,2)-G(y,x,2);
        roidif(:,:,3)=roi(:,:,3)-G(y,x,3);
        roidif=roidif.^2;
        roidif=roidif(:,:,1)+roidif(:,:,2)+roidif(:,:,3);
        tonalKernel =exp(- roidif/(2*sigma_r^2));
        W=(tonalKernel.*spatialKernel);
        k=sum(W(:));
        RC=W.*roi(:,:,1);
        GC=W.*roi(:,:,2);
        BC=W.*roi(:,:,3);
        rc(y,x)=sum(RC(:))/k;
        gc(y,x)=sum(GC(:))/k;
        bc(y,x)=sum(BC(:))/k;
    end
end
J=cat(3,rc,gc,bc);
end