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
 randn(4,30),randn(4,1),'logsig',P,T,[1 10000 0.00001, 0.4]);


disp('test network')
disp('Network output=>');
t1 =w1*P;
layer1out=logsig(t1,b1);
t2 = w2*layer1out;
layer2out=logsig(t2,b2)
t3 = w3*layer2out;
network_out=logsig(w3*layer2out,b3)
num_decide(network_out);


% Demonstration Script

kdemo = 1;
while (kdemo>=1)&&(kdemo<=2)
  clc;
  kdemo = menu('Choose a Demo',...
           'Run The trained neural network',...
           'Quit');


if kdemo==1, 
   clc
   %recObj = audiorecorder(8000,8,1);
  % disp('Start speaking.')
   %recordblocking(recObj, 2);
  % disp('End of Recording.');
   [myRecording,Fs] = audioread('TEST.WAV')
 
   display(myRecording);
   PP=melfunction(myRecording);
   dd = PP;
   PP=PP';
   %Nueral Network to Arduino
   aa=logsig(w1*PP,b1);
   bb=logsig(w2*aa,b2);
   network_out=logsig(w3*bb,b3);
   num_decide(network_out);
   pause(10)
end

if kdemo==2, 
   clc
   disp('END PROGRAM');
   kdemo = 0;
  
end
end
close all
clear all


