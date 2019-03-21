
close all
clear all
clc

% Training input patterns:
P=[ -1 -1 -1 1 -1 1 1 -1 1; -1 1 -1 -1 -1 -1 -1 1 -1]';

% trraining output patterns:
T=[0.1 0.1 0.1 ; 0.9 0.9 0.9]';

% teach the neural network with two layers
[w1, b1, w2, b2, te ,tr]=...
 trainbp(randn(20,9),randn(20,1),'logsig',...
 randn(3,20),randn(3,1),'logsig',P,T,[1 100 0.001, 1]);


disp('test network')
disp('Network output=>');
layer1out=logsig(w1*P,b1);
network_out=logsig(w2*layer1out,b2)
disp('weights for layer 1:');
w1
b1
disp('weights for layer 2:');
w2
b2
pause

% Demonstration Script

kdemo = 1;
while (kdemo>=1)&&(kdemo<=3),
  clc;
  kdemo = menu('Choose a Demo',...
           'Input test patten',...
           'Run the tranined neural network',...
           'Output the neural network weights',...
           'Quit');

if kdemo==1,
  PP = input('Test pattern (9 elements):')
  PP=PP';
  figure 
  axis([1 3 1 3]);
  grid
  hold on
  for i=1:1:3
   if PP(i) == -1
    plot(i,3,'*');
   end
  end
  for i=4:1:6
   if PP(i) == -1
    plot(i-3,2,'*');
   end
  end
  for i=7:1:9
   if PP(i) == -1
    plot(i-6,1,'*');
   end
  end
  pause;
end

if kdemo==2, % Demonstration 1.
   clc
   disp('result');
   aa=logsig(w1*PP,b1);
   network_out=logsig(w2*aa,b2)
   pause
end
if kdemo==3, % Demonstration 1.
   clc
   disp('neural network weights');
   w1
   b1
   w2
   b2
   pause
end
end
close all
clear all

