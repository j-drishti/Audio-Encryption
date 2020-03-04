[x,Fs]=audioread('sampleaudio1.wav');    %reading audio
 %Bit depth of sample values
% player=audioplayer(x,Fs,nbits) ; properties of the audio
length_of_audio=length(x(:,1));
x_fft=fft(x(:,1),length_of_audio); 
%we use centered dft so that zero frequency component is shifted to the
%middle ie length_of_audio/2
% (length_of_audio/2)+1 ; %mid-point

x_cfft=fftshift(x_fft);
magn_xcfft=abs(x_cfft);
phase_xcfft=angle(x_cfft);
%f=(-length_of_audio/2:length_of_audio/2-1)';
%subplot(2,1,1);
%plot(f,abs(x_cfft));
%title('magnitude response before embedding')

%{
The selected band is divided into short frames and a 
single secret bit is embedded into each frame. Based 
on corresponding secret bit, all samples in each frame
 should be changed by the average of all samples or the 
average multiplied by a factor. 
%}
%random bits 
secret_bit= [1 0 0 1 1 1 0 1 0 1 0 1 0 1 1 1 1 1 1 0 0 0 1 0 0 1 0 1 0 1 0 1 0 0 0 0 1 1 1 0 0 0 0 1 0 1 0 1 0 1 0 1 0 1 0 0 0 1 1 1 0 0 0 0 1 1 1 1 1 1 0 0 1 0 1 0 1 0 1 0 1 0 0 1 0 1 0 1 0 0];
frame=90;   samples=20;         %total no of bits in embedding signal     
  total_samples=  frame*samples;           

Y=  magn_xcfft;
%selecting portion for embedding 
 embedding=  magn_xcfft( (((length_of_audio/2)+1)-10000-(total_samples)):(((length_of_audio/2)+1)-10001) ) ; 


%{
If the secret bit is â€œ0â€?, all FFT magnitudes 
should be changed by the average of all FFT magnitudes
in the frame. If the secret bit is â€œ1â€?, we divide the FFT
samples into two groups based on the sequence and, then, we
change the magnitude of the first group using a scale factor, 
Î±, multiplying the average of all samples and the magnitude of
the second group multiplying (2 â€“ Î±) by the average.
%}

alpha= 0.2  ;
embedding_matrix=  vec2mat(embedding,samples)  ;
for i=1:frame            
  aver=0; 
if( secret_bit(i)==0 )
 for l=1:samples
 aver=aver+embedding_matrix(i,l);
 end
   aver=aver/samples;
for l=1:samples
  embedding_matrix(i,l)=aver;
end

 else
for l=1:samples
  aver=aver+ embedding_matrix(i,l ) ;
end
  aver=aver/samples;
for l=1:samples/2
 embedding_matrix( i,l )= alpha*aver ;
end
for l=samples/2+1:samples 
embedding_matrix(i,l)=(2-alpha)*aver ;
end
end
end
 embedding_matrix=   embedding_matrix'  ;
y=(embedding_matrix(:) )';
%{
 These changes both in embedding â€œ0â€? or â€œ1â€?, 
keep the average of the frame unchanged after embedding.
%}
s1= ( (((length_of_audio/2)+1)-10000-(total_samples)):(((length_of_audio/2)+1)-10001)) ;
s2=((((length_of_audio/2)+1)+10001):(((length_of_audio/2)+1)+10001+(total_samples-1)));
%adding watermark here
Y( s1 )=y;

 Y( s2 )= fliplr(y)  ;
%embedded signal
output=Y.*exp(1i*phase_xcfft);
%subplot(2,1,2);
%plot(f,abs(Y1));
%axis([6000 6500 0 800])
%title('magnitude response after embedding')
%axis([-60000 60000 0 800])
output_inv=ifft(ifftshift(output));
filename='embeded_signal.wav';
audiowrite(filename,output_inv,Fs);
subplot(2,1,1);
specgram(x(:,1));
title('original file');
subplot(2,1,2);
specgram(output_inv(:,1));
title('Encoded file');
