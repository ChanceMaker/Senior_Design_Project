function [x] = dctcoef()
 x = zeros(12,24);


for k=1:12  
    n=0:23;  
    x(k,:) = cos((2*n+1)*k*pi/(2*24)); 
    
end   

