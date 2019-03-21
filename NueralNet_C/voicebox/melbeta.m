% MFCC implement with Matlab %  
Fs = 8000;

[x Fs]=audioread('zero.wav');  
d0=melfunction(x);
[x Fs]=audioread('one.wav');  
d1=melfunction(x);
[x Fs]=audioread('two.wav');  
d2=melfunction(x);
[x Fs]=audioread('three.wav');  
d3=melfunction(x);
[x Fs]=audioread('four.wav');  
d4=melfunction(x);
[x Fs]=audioread('five.wav');  
d5=melfunction(x);
[x Fs]=audioread('six.wav');  
d6=melfunction(x);
[x Fs]=audioread('seven.wav');  
d7=melfunction(x);
[x Fs]=audioread('eight.wav');  
d8=melfunction(x);
[x Fs]=audioread('nine.wav');  
d9=melfunction(x);

P=[d0;d1;d2;d3;d4;d5;d6;d7;d8;d9]';
P = round(P,1);
% Training outputs:
T=[0.1 0.1 0.1 0.1;0.1 0.1 0.1 0.9;0.1 0.1 0.9 0.1;0.1 0.1 0.9 0.9;
    0.1 0.9 0.1 0.1;0.1 0.9 0.1 0.9;0.1 0.9 0.9 0.1;0.1 0.9 0.9 0.9;
    0.9 0.1 0.1 0.1;0.9 0.1 0.1 0.9]';

% teach 1-layer network
[w1, b1, w2, b2, w3, b3, te ,tr]=...
 trainbp(randn(160,24),randn(160,1),'logsig',...
 randn(30,160),randn(30,1),'logsig',...
 randn(4,30),randn(4,1),'logsig',P,T,[1 1000 0.001, 0.4]);


disp('test network')
disp('Network output=>');
layer1out=logsig(w1*P,b1);
layer2out=logsig(w2*layer1out,b2)
network_out=logsig(w3*layer2out,b3)
num_decide(network_out)
disp('weights for layer 1:');
w1
b1
disp('weights for layer 2:');
w2
b2
disp('weights for layer 3:');
w3
b3
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
  PP = input('Test pattern (dn):')
  PP=PP';
  figure 
  axis([1 10 1 10]);
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
  pause
end

if kdemo==2, % Demonstration 1.
   clc
   PP = input('Test pattern (dn):')
   PP=PP';
   disp('result');
   aa=logsig(w1*PP,b1);
   bb=logsig(w2*aa,b2);
   network_out=logsig(w3*bb,b3)
   num_decide(network_out)
   pause
end
if kdemo==3, % Demonstration 1.
   clc
   disp('neural network weights');
   w1
   b1
   w2
   b2
   w3
   b3
   pause
end
end
close all
clear all

