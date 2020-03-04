function out=in(strg)
    for i=1:1:length(strg)
        out(i)=strg(i);
        switch strg(i)
            case 'H'
                out(i)='A';
            case 'L'
                out(i)='B';
            case 'N'
                out(i)='C';
            case 'O'
                out(i)='D';
            case 'T'
                out(i)='E';
            case 'V'
                out(i)='F';
            case 'W'
                out(i)='1';
            case 'Z'
                out(i)='3';
            case 'a'
                out(i)='4';
            case 'b'
                out(i)='5';
            case 'e'
                out(i)='6';
            case 'f'
                out(i)='7';
            case 'h'
                out(i)='8';
            case 'm'
                out(i)='-';
            case 'A'
                out(i)='H';
            case 'B'
                out(i)='L';
            case 'C'
                out(i)='N';
            case 'D'
                out(i)='O';
            case 'E'
                out(i)='T';
            case 'F'
                out(i)='V';
            case '1'
                out(i)='W';
            case '3'
                out(i)='Z';
            case '4'
                out(i)='a';
            case '5'
                out(i)='b';
            case '6'
                out(i)='e';
            case '7'
                out(i)='f';
            case '8'
                out(i)='h';
            case '-'
                out(i)='m';
        end
    end
end