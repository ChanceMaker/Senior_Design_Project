function [ c ] = melfunction( x )
%#codegen
bank=melbankm(24,256,8000,0,0.4,'t');  
bank=full(bank); %full() convert sparse matrix to full matrix  
bank=bank/max(bank(:));

w=1+6*sin(pi*(1:12)./12);
w=w/max(w); 
xx=double(x);  
xx=filter((1-0.9375),1,xx); 
xx=enframe(xx,256,80);
 p = zeros(256);
 m = zeros(197,12);
 
for i=1:size(xx,1)
   
    y=xx(i,:);  
    s=y'.*hamming(256);  
    t=abs(fft(s));
    t=t.^2; 
    p(i,:) = t;
    c1=dctcoef*log(bank*t(1:129));  
    c2=c1.*w';  
    m(i,:)=c2;  
end 
pp = sum(p);
   c1=dctcoef*log(bank*pp(1:129)');  
   c2=c1.*w';  
 
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
[~,~]=size(ccc);  
%A=size(ccc);  


c=[c1;c2];
c=c';

end

