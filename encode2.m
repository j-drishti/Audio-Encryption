function out=encode2(str_in)
  
    for i=1:1:length(str_in) % for each character
        str_in(i)=in(str_in(i)); % Shift special bits.
        if(str_in(i)>=48 && str_in(i)<=57) %0-9
            no=22;
        elseif(str_in(i)>=65 && str_in(i)<=90) %A-Z
            no=65;
        elseif(str_in(i)==92) 
            no=29;
        elseif(str_in(i)>=97 && str_in(i)<=122) %a-z
            no=60;
        elseif(str_in(i)==45) %-
            no=9;
        else
            no=str_in(i)-63; % \ for invalid bits,
        end
        temp=dec2bin(str_in(i)-no); 
        for j=1:1:6 % to a matrix.
            if(length(temp)<6)
                if(j<=6-length(temp)) % special case if temp is not 6 bits long.
                    matr(i,j)='0';
                else
                    matr(i,j)=temp(j-(6-length(temp)));
                end
            else
                matr(i,j)=temp(j);
            end
        end
    end
    
    out=matr(1,:); %starting value.
    for i=2:1:length(str_in) % mat to arr.
        out=[out matr(i,:)];
    end
    
end