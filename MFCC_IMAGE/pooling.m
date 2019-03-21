function state=pooling(data,pooling_a)
%%pooling
[data_row,data_col]=size(data);
[pooling_row,pooling_col]=size(pooling_a);
for n=1:data_col/pooling_col
    for m=1:data_row/pooling_row
        state(m,n)=sum(sum(data(2*m-1:2*m,3*n-2:3*n).*pooling_a));
    end
end
end