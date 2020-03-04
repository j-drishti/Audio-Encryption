%AUDIO WATERMARKING

key=[20,89,31,2,67,18,26,4,75]; % key array with random values
msg='DSP-PROJECT'; % watermark string.
[aud, fs]= audioread('random.wav');
fy=watermark(aud,msg,key);
subplot(2,1,1);
specgram(aud(:,1));
title('Original file');
subplot(2,1,2);
specgram(fy(:,1));
title('Encoded file');
%sound(fy,fs);pause(5) ;



