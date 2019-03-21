close all
clear all
clc

% Two training input paterns:
P=[ -1 -1 -1 1 -1 1 1 -1 1; -1 1 -1 -1 -1 -1 -1 1 -1]';
% Training outputs:
T=[0.1 0.1 0.1 ;0.9 0.9 0.9]';

% teach 1-layer network
[w1, b1,te ,tr]=...
 trainbp(randn(3,9),randn(3,1),'logsig',...
 P,T,[1 100 0.001, 1]);


disp('test network')
disp('Network output=>');
network_out=logsig(w1*P,b1)
disp('weight:');
w1
b1

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
   network_out=logsig(w1*PP,b1)
   pause
end
if kdemo==3, % Demonstration 1.
   clc
   disp('neural network weights');
   w1
   b1
   pause
end
end
close all
clear all

