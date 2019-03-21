% test program
clc; close all; clear ll
trd =[1 1 1 1 1 1 0; 0 0 1 1 0 0 0; 0 1 1 0 1 1 1; 0 1 1 1 1 0 1;...
     1 0 1 1 0 0 1; 1 1 0 1 1 0 1; 1 1 0 1 1 1 1 ; 0 1 1 1 0 0 0; 1 1 1 1 1 1 1; 1 1 1 1 1 0 1]; % training features 7 segments
tr=[trd; trd; trd; trd; trd; trd; trd; trd; trd; trd];
y_tr= [0 1 2 3 4 5 6 7 8 9];  % tranining class
y_tr=[y_tr y_tr y_tr y_tr y_tr y_tr y_tr y_tr y_tr y_tr];
test_data=[trd]; % test features
y_test=[0 1 2 3 4 5 6 7 8 9]'; % test class
[yy err]=knn(test_data,y_test, tr, y_tr, 10)
