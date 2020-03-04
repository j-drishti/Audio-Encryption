function out=encode(inp, key)
% Flips the bits as per the key value
    len_inp=length(inp);
    len_key=length(key); 
    for i=1:len_key
        for j=1:len_inp
            n=mod(j+key(i)-1,len_inp)+1; %select the bit to switch with j.
            temp=inp(j); %swap
            inp(j)=inp(n);
            inp(n)=temp;
        end
    end
    out=inp; % output the result
end