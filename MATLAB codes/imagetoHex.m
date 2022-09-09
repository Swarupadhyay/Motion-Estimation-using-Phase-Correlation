%IMAGE TO HEX

b=imread('C:\Users\Paras Gupta\Desktop\32P1.png');

I = rgb2gray(b);

fid = fopen('32P1.hex', 'wt');
fprintf(fid, '%x\n', I);
disp('Text file write done');disp(' ');
fclose(fid);