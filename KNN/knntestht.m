% test program
clc; close all; clear ll
tr =[-1 -1 -1 1 -1 1 1 -1 1; -1 1 -1 -1 -1 -1 -1 1 -1]; % training features THTHTHTHTH
tr=[tr; tr; tr; tr; tr];
y_tr= [0 1 0 1 0 1 0 1 0 1];  % tranining class
test_data=[-1 -1 -1 1 -1 1 1 -1 1; -1 1 -1 -1 -1 -1 -1 1 -1; ]; % test features
y_test=[0 1]'; % test class
[yy err]=knn(test_data,y_test, tr, y_tr, 2)
