%function [state]=convolution(data,kernel)

a=open(strcat(num2str(1),'_',num2str(1),'.fig'));
h=get(gca,'Children');
data=get(h,'Cdata');
kernel=[1 1 1 1 1;1 1 1 1 1;1 1 1 1 1;1 1 1 1 1;1 1 1 1 1];
[data_row,data_col]=size(data);
[kernel_row,kernel_col]=size(kernel);
for n=1:data_col-kernel_col+1
    for m=1:data_row-kernel_row+1
        state(m,n)=sum(sum(data(m:m+kernel_row-1,n:n+kernel_col-1).*kernel));
    end
end
