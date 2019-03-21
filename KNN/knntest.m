% test program
clc; close all; clear ll
tr =[2 5; 1 6; 2 7; 3 9; 5 2; 6 1; 7 2; 9 3]; % training features
y_tr= [0 0 0 0 1 1 1 1];  % tranining class
test_data=[2 5; 6 4]; % test features
y_test=[0 1]'; % test class
[y err]=knn(test_data,y_test, tr, y_tr, 3)
plot([2 1 2 3],[5 6 7 9],'*',[5 6 7 9],[2 1 2 3],'+'); hold
plot([4 6],[5 4],'o')