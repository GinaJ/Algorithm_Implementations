clear all;
Max_char=4;%number of char per element in txt file
N=4;% size of the matrix
fid = fopen('matrix_a.txt');
tline = fgetl(fid);
riga=0;
while ischar(tline)
riga=riga+1;

s=size(tline);
s=s(2);
Stringa=sprintf('lenght= %g\n',s);
for col= 1:N
A(riga:riga,col:col)=hex2dec(tline((col-1)*Max_char+1:(col)*Max_char));
end

tline = fgetl(fid);
end
fclose(fid);




intimgA=integralImage(A);
fid = fopen('matrix_sat_MATLAB.txt','wt');
for ii = 1:size(A,1)
P=dec2hex(intimgA(ii+1,2:N+1));
for i2 = 1:size(A,1)
z=(size(P(i2:i2,:)));
for i3 =z(2):Max_char-1
fprintf(fid,'0');
end
fprintf(fid,'%s',P(i2:i2,:));
end
fprintf(fid,'\n');
end
fclose(fid)

visdiff('matrix_sat_MATLAB.txt', 'matrix_sat_TB.txt')