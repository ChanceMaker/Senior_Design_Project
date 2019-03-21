function record()

   recObj = audiorecorder(8000,8,1);
   disp('Start speaking.')
   recordblocking(recObj, 2);
   disp('End of Recording.');