function [y, perr] = knn(test_data, y_test, tr_data,y_tr, k)
% this code is obtained from the website and modified
% August 2, 2016
%
% Input:
% tr_data = training feature= each row contains feastures
% y_tr = class = each row contains the class (integer)
% test_data= test feature = each row continas feastures
% y_test = class
% k= the number of neighbors to be used for classification 
% output
% y= assigned class
% perr= percentage of error
%
numoftestdata = size(test_data,1);
numoftrainingdata = size(tr_data,1);
for sample=1:numoftestdata

   %Step 1: Computing euclidean distance for each testdata
   R = repmat(test_data(sample,:),numoftrainingdata,1) ;
%B = repmat(A,M,N) creates a large matrix B consisting of an M-by-N
%   tiling of copies of A
   euclideandistance  = (sum(((R(:,:) - tr_data(:,:)).^2)'))'; 
   % diferent distance metric can be used
   
   %Step 2: compute k nearest neighbors and store them in an array
    [dist position] = sort(euclideandistance,'ascend');
    knearestneighbors=position(1:k);
    knearestdistances=dist(1:k);

    % Step 3 : Voting 
     for i=1:k
        A(i) = y_tr(knearestneighbors(i));  
     end
      M= mode(A); % find the class
      y(sample)=M;
end 
     y=y';
     perr=sum(abs(y-y_test))/length(y_test);
end