# Audio-Encryption
Project uses cryptography and FFT to encrypt audio via two different methods
The idea behind the project is to implement Watermarking, a strategy that allows addition of copyright information.
The main theory behind this project deploys the use of the Fast Fourier Transform(FFT). A Masking Effect is employed to make it difficult for the listener
to gather the information under the audio. 
Another method uses cryptography to conceal the real audio and imposes the encrypted msg upon the original audio file. This is turn, destroys the
original audio without disturbing the message or the frequency; making any info leak extremely difficult to comprehend. 
