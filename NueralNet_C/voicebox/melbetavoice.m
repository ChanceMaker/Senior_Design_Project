% MFCC implement with Matlab
% Written By: Cedrick E Baker
%Getting data from five zero samlpes
Fs = 8000;
[x Fs]=audioread('zero_1.wav');
[x1 Fs]=audioread('zero_2.wav');
%[x2 Fs]=audioread('zero_2.wav');
%[x3 Fs]=audioread('zero_3.wav');
%[x4 Fs]=audioread('zero_4.wav');
d0=melfunction(x);
d0_1=melfunction(x1);
%d0_2=melfunction(x2);
%d0_3=melfunction(x3);
%d0_4=melfunction(x4);
%Getting data from five one samples
[x Fs]=audioread('one_1.wav');
[x1 Fs]=audioread('one_2.wav');
%[x2 Fs]=audioread('one_2.wav');
%[x3 Fs]=audioread('one_3.wav');
%[x4 Fs]=audioread('one_4.wav');
d1=melfunction(x);
d1_1=melfunction(x1);
%d1_2=melfunction(x2);
%d1_3=melfunction(x3);
%d1_4=melfunction(x4);
%Getting data from five two samples
[x Fs]=audioread('two_1.wav');
[x1 Fs]=audioread('two_2.wav');
%[x2 Fs]=audioread('two_2.wav');
%[x3 Fs]=audioread('two_3.wav');
%[x4 Fs]=audioread('two_4.wav');
d2=melfunction(x);
d2_1=melfunction(x1);
%d2_2=melfunction(x2);
%d2_3=melfunction(x3);
%d2_4=melfunction(x4);

%Getting data from five three samples
[x Fs]=audioread('three_1.wav');
[x1 Fs]=audioread('three_2.wav');
%[x2 Fs]=audioread('three_2.wav');
%[x3 Fs]=audioread('three_3.wav');
%[x4 Fs]=audioread('three_4.wav');
d3=melfunction(x);
d3_1=melfunction(x1);
%d3_2=melfunction(x2);
%d3_3=melfunction(x3);
%d3_4=melfunction(x4);
%Getting data from five four samples
[x Fs]=audioread('four_1.wav');
[x1 Fs]=audioread('four_2.wav');
%[x2 Fs]=audioread('four_2.wav');
%[x3 Fs]=audioread('four_3.wav');
%[x4 Fs]=audioread('four_4.wav');
d4=melfunction(x);
d4_1=melfunction(x1);
%d4_2=melfunction(x2);
%d4_3=melfunction(x3);
%d4_4=melfunction(x4);
%Getting data from five five samples
[x Fs]=audioread('five_1.wav');
[x1 Fs]=audioread('five_2.wav');
%[x2 Fs]=audioread('five_2.wav');
%[x3 Fs]=audioread('five_3.wav');
%[x4 Fs]=audioread('five_4.wav');
d5=melfunction(x);
d5_1=melfunction(x1);
%d5_2=melfunction(x2);
%d5_3=melfunction(x3);
%d5_4=melfunction(x4);
%Getting data from five six samples
[x Fs]=audioread('six_1.wav');
[x1 Fs]=audioread('six_2.wav');
%[x2 Fs]=audioread('six_2.wav');
%[x3 Fs]=audioread('six_3.wav');
%[x4 Fs]=audioread('six_4.wav');
d6=melfunction(x);
d6_1=melfunction(x1);
%d6_2=melfunction(x2);
%d6_3=melfunction(x3);
%d6_4=melfunction(x4);
%Getting data from five seven samples
[x Fs]=audioread('seven_1.wav');
[x1 Fs]=audioread('seven_2.wav');
%[x2 Fs]=audioread('seven_2.wav');
%[x3 Fs]=audioread('seven_3.wav');
%[x4 Fs]=audioread('seven_4.wav');
d7=melfunction(x);
d7_1=melfunction(x1);
%d7_2=melfunction(x2);
%d7_3=melfunction(x3);
%d7_4=melfunction(x4);
%Getting data from five eight samples
[x Fs]=audioread('eight_1.wav');
[x1 Fs]=audioread('eight_2.wav');
%[x2 Fs]=audioread('eight_2.wav');
%[x3 Fs]=audioread('eight_3.wav');
%[x4 Fs]=audioread('eight_4.wav');
d8=melfunction(x);
d8_1=melfunction(x1);
%d8_2=melfunction(x2);
%d8_3=melfunction(x3);
%d8_4=melfunction(x4);
%Getting data from five nine samples
[x Fs]=audioread('nine_1.wav');
[x1 Fs]=audioread('nine_2.wav');
%[x2 Fs]=audioread('nine_2.wav');
%[x3 Fs]=audioread('nine_3.wav');
%[x4 Fs]=audioread('nine_4.wav');
d9=melfunction(x);
d9_1=melfunction(x1);
%d9_2=melfunction(x2);
%d9_3=melfunction(x3);
%d9_4=melfunction(x4);


P=[d0;d0_1;...
    d1;d1_1;...
    d2;d2_1;...
    d3;d3_1;... 
    d4;d4_1;...
    d5;d5_1;...
    d6;d6_1;...
    d7;d7_1;...
    d8;d8_1;...
    d9;d9_1]';
P = round(P,1);
% Training outputs:
T=[0.1 0.1 0.1 0.1;0.1 0.1 0.1 0.1;...
    0.1 0.1 0.1 0.9;0.1 0.1 0.1 0.9;...
    0.1 0.1 0.9 0.1;0.1 0.1 0.9 0.1;...
    0.1 0.1 0.9 0.9;0.1 0.1 0.9 0.9;...
    0.1 0.9 0.1 0.1;0.1 0.9 0.1 0.1;...
    0.1 0.9 0.1 0.9;0.1 0.9 0.1 0.9;...
    0.1 0.9 0.9 0.1;0.1 0.9 0.9 0.1;...
    0.1 0.9 0.9 0.9;0.1 0.9 0.9 0.9;...
    0.9 0.1 0.1 0.1;0.9 0.1 0.1 0.1;...
    0.9 0.1 0.1 0.9;0.9 0.1 0.1 0.9;]';

% teach 1-layer network
[w1, b1, w2, b2, w3, b3, te ,tr]=...
 trainbp(randn(160,24),randn(160,1),'logsig',...
 randn(30,160),randn(30,1),'logsig',...
 randn(4,30),randn(4,1),'logsig',P,T,[1 10000 0.00001, 0.4]);


kdemo = 1;
while (kdemo>=1)&&(kdemo<=3)
  clc;
  kdemo = menu('Choose a Demo',...
           'Run The trained neural network',...
           'Print weights',...
           'Quit');


if kdemo==1, 
   clc
   recObj = audiorecorder(8000,8,1);
   disp('Start speaking.')
   recordblocking(recObj, 2);
   disp('End of Recording.');

   play(recObj);

   myRecording = getaudiodata(recObj); 
   display(myRecording)
   PP=melfunction(myRecording);

   PP=PP';
   %Nueral Network to Arduino
   aa=logsig(w1*PP,b1);
   bb=logsig(w2*aa,b2);
   network_out=logsig(w3*bb,b3);
   num_decide(network_out);
   pause(10)
end
if kdemo == 2,
    disp(w1(1,:)); 
    disp(w2(1,:));
    disp(w3(1,:)) 
    
    %Writing data to file for pyton extraction
    fileId = fopen('Neuron_weights.txt','w');
    %write to file w1 weights
    [m0,n0] = size(w1(1,:));
    [m1,n1] = size(w1(:,1));
  
    for i = 1:m1
        for j = 1:n0
            fprintf(fileId,'%f ',w1(i,j));
        end
        fprintf(fileId,'\n');
    end
    fprintf(fileId,'\n');
    %w2 weights
    [m0,n0] = size(w2(1,:));
    [m1,n1] = size(w2(:,1));
  
    for i = 1:m1
        for j = 1:n0
            fprintf(fileId,'%f ',w2(i,j));
        end
        fprintf(fileId,'\n');
    end
    fprintf(fileId,'\n');
    %w3 weights
    [m0,n0] = size(w3(1,:));
    [m1,n1] = size(w3(:,1));
  
    for i = 1:m1
        for j = 1:n0
            fprintf(fileId,'%f ',w3(i,j));
        end
        fprintf(fileId,'\n');
    end
    fprintf(fileId,'\n');
    pause(10)
    kdemo = 1;
    fclose(fileId);
    
end

if kdemo==3, 
   clc
   disp('END PROGRAM');
   kdemo = 0;
  
end

end
close all
clear all

