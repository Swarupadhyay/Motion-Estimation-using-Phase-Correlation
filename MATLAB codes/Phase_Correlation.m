%PHASE CORRELATION

b=imread('C:\Users\Paras Gupta\Desktop\32P1.png');
I = rgb2gray(b);
c=imread('C:\Users\Paras Gupta\Desktop\32P2.png');
J = rgb2gray(c);
If = fft2(I);
Jf = fft2(J);
Jfc = conj(Jf);
R = (If.*Jfc)/abs(If.*Jfc);
r = ifft2(R);
xmax = max(r);
x = max(xmax);
[p, q] = find(r == x)



