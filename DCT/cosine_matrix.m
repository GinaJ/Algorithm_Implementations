

clear all;
N=4; %lenght of matrix
ndec=16; %bits for integer part
nfloat=16;%bits for floating part
for riga= 1:N
for col= 1:N

    if riga==1
    cost(riga:riga,col:col)=sqrt(1/N)*cos(((pi)/(N))*((col-1)+0.5)*((riga-1)));
    else 
        cost(riga:riga,col:col)=sqrt(2/N)*cos(((pi/(N)))*((col-1)+0.5)*((riga-1)));
    
end
end
end


fid = fopen('matrix_dct_MATLAB.txt','wt');
for ii = 1:size(cost,1)
  

%P=dec2hex(cost(ii,1:N));
for i2 = 1:size(cost,1)
    x=cost(ii,i2);
    if x>=0
        s=fix(rem(x*pow2(-(ndec-1):nfloat),2));
    else x=abs(x);
        x=x+(1/(2^nfloat));
        s=not(fix(rem(x*pow2(-(ndec-1):nfloat),2)));
    end
%z=(size(s));
%for i3 =z(2):Max_char-1
%fprintf(fid,'0');
%end
z=(size(s));
for c=1:z(2)
fprintf(fid,'%g',s(c));
end
%fprintf(fid,'-');
end
fprintf(fid,'\n');
end
fclose(fid)