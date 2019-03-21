%Operating platform
%Recorded for 2 seconds
recObj = audiorecorder(8000,8,1);
disp('Start speaking.')
recordblocking(recObj, 2);
disp('End of Recording.');

% Playback of recorded data
play(recObj);

% Get the recording data
myRecording = getaudiodata(recObj);
% Draw the recording data waveform
plot(myRecording);
% Save Recording into variable filename with t
% the name int ''
filename = 'example.wav';
% Write the fle myRecording to the filename at 8000 hz
audiowrite(filename,myRecording,8000);
