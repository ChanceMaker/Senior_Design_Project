function [ c ] = melfunction( x )
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
bank=melbankm(24,256,8000,0,0.4,'t');  
bank=full(bank); %full() convert sparse matrix to full matrix  
bank=bank/max(bank(:));  
for k=1:12  
    n=0:23;  
    dctcoef(k,:)=cos((2*n+1)*k*pi/(2*24));  
end  
w=1+6*sin(pi*[1:12]./12);
w=w/max(w); 
xx=double(x);  
xx=filter([1-0.9375],1,xx); 
xx=enframe(xx,256,80);  
 
for i=1:size(xx,1)  
    y=xx(i,:);  
    s=y'.*hamming(256);  
    t=abs(fft(s));%FFT快速傅里叶变换  
    t=t.^2;  
    p(i,:)=t;
    c1=dctcoef*log(bank*t(1:129));  
    c2=c1.*w';
    m(i,:)=c2;  
end  
pp=sum(p);
c1=dctcoef*log(bank*pp(1:129)');  
c2=c1.*w';   


%求一阶差分系数  
dtm=zeros(size(m));  
for i=3:size(m,1)-2  
    dtm(i,:)=-2*m(i-2,:)-m(i-1,:)+m(i+1,:)+2*m(i+2,:);  
end  
dtm=dtm/3;  
 
dtmm=zeros(size(dtm));  
for i=3:size(dtm,1)-2  
    dtmm(i,:)=-2*dtm(i-2,:)-dtm(i-1,:)+dtm(i+1,:)+2*dtm(i+2,:);  
end  
dtmm=dtmm/3;  
 
ccc=[m dtm dtmm];  

ccc=ccc(3:size(m,1)-2,:);  
ccc;  
subplot(2,1,1);  
ccc_1=ccc(:,1);  
plot(ccc_1);
title('MFCC');
ylabel('Amplitude');  
[h,w]=size(ccc);  
A=size(ccc);  
subplot(2,1,2);  
plot([1,w],A);
xlabel('Dimension');ylabel('Amplitude'); 
c=[c1;c2];
c=c';

end

