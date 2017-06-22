clear all;
N=6; %lenght of matrix
ndec=16; %bits for integer part
nfloat=16;%bits for floating part

fid = fopen('matrix_dct_TB.txt');
fid2 = fopen('matrix_res_dct_matlab.txt','wt');

for riga=1:N
    
        tline = fgetl(fid);
        
        if tline(1)=='0'
            
        n_int=tline(1:(ndec));
        n_float=tline((ndec+1):(ndec+nfloat));
        n_int=bin2dec(n_int);
        n_float=bin2dec(n_float);
        x=n_int;
        n_float=n_float/(2^nfloat);
        x=x+n_float;
        fprintf(fid2,'%f\n',x);
        
        
        else 
            for i=1:(ndec+nfloat)
                if tline(i)=='0' 
                    tline(i)='1';
                else
                     tline(i)='0';
                end
            end
        n_int=tline(1:(ndec));
        n_float=tline((ndec+1):(ndec+nfloat));
        n_int=bin2dec(n_int);
        n_float=bin2dec(n_float);
        x=n_int;
        n_float=(n_float+1)/(2^nfloat);
        x=x+n_float;
        fprintf(fid2,'-%f\n',x);
        
        end

end
fclose(fid);