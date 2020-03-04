function out=watermark(aud,msg,key)
    [M,N]=size(aud);
    crypt=encode(encode2(msg),key); %encrypt
    chnnl=floor(length(crypt)/N);   %divide into channels
    
    for z=1:N
        y=aud(:,z);
        code=crypt((chnnl+1):end);
        %FFT of each frame
        for i=1:length(code)
            fY(:,i) = fft(y((3969*(i-1)+1):(3969*i)));   %3969- interval time
            fY(1,i)=fY(1,i)-real(fY(1,i))+abs(real(fY(1,i)))*(2*str2num(code(i))-1);
        end
        eof=i; %for consistency; unused part of file

        y1=ifft(fY);
        y2=[];
        for i=1:length(code)
            y2=[y2;real(y1(:,i))];
        end
        y3=[y2;y((3969*(eof-1)+1):end)];    %appending eof
        out(:,z)=y3;
    end
end