% pkg install "https://github.com/gnu-octave/statistics/releases/download/release-1.7.5/statistics-1.7.5.tar.gz"
% pkg install "https://downloads.sourceforge.net/project/octave/Octave%20Forge%20Packages/Individual%20Package%20Releases/signal-1.4.6.tar.gz"
% pkg install "https://github.com/gnu-octave/pkg-control/releases/download/control-4.1.3/control-4.1.3.tar.gz"
% pkg install "https://downloads.sourceforge.net/project/octave/Octave%20Forge%20Packages/Individual%20Package%20Releases/matgeom-1.2.4.tar.gz"

pkg load statistics
pkg load signal
pkg load control
% pkg load matgeom

% format short g

U = [
15.01
14.00
13.01
12.01
11.02
10
9.02
8.02
7.02
6.02
5.006
4.017
3.03
2.01
1.034
];

U_range = [
60
60
60
60
60
60
60
60
60
60
6
6
6
6
6
];

I = [
0.04963
0.04632
0.04305
0.03972
0.03642
0.03305
0.02978
0.02650
0.02321
0.01989
0.01652
0.01326
0.01000
0.00663
0.00341
];

I_range = [
0.06
0.06
0.06
0.06
0.06
0.06
0.06
0.06
0.06
0.06
0.06
0.06
0.06
0.06
0.06
];

format short
uI = (I*0.7*0.01 + I_range*0.03*0.01)/sqrt(3)

uU = (U*0.7*0.01 + U_range*0.05*0.01)/sqrt(3)

% format bank
matrix = [U, U_range, I, I_range]

% U_rms = rms(U)

% fitlm(I,U)

x=10;


% L = lineFit(I, U)

% ols(I, U)


% a=[I,ones(size(I))]
% b=U
%
% coefs=a\b
% fit = coefs(1)*a+coefs(2)
% plot(I,U,'ro',I,fit)

% errorbar(X, Y, err)
% figure (1);

format short

fit1 = polyfit(I,U,1);
y_fit1=fit1(1)*I+fit1(2);
residuals1 = U-y_fit1;
RSS1=sum(residuals1.^2);
CHI1=sum((residuals1 ./ uU).^2);
% X2 obliczono zgodnie z artykułem https://pl.wikipedia.org/wiki/Test_chi-kwadrat

figure(1)
p1 = errorbar(I, U, uU);
set(p1, "linestyle", "none");
set(p1, "marker", "+");
xlabel ("I(A)");
ylabel ("U(V)");
hold on;
plot(I, y_fit1, 'r-')
hold off;
legend("U(I)","fit")
title ("U(I) characteristic");

%=======

fit2 = polyfit(U,I,1);
y_fit2=fit2(1)*U+fit2(2);
residuals2 = I-y_fit2;
RSS2=sum(residuals2.^2);
CHI2=sum((residuals2 ./ uI).^2);

figure(2)
p2=errorbar(U, I, uI);
set(p2, "linestyle", "none");
set(p2, "marker", "+");
xlabel ("U(V)");
ylabel ("I(A)");
hold on;
plot(U, y_fit2, 'r-')
hold off;
legend("I(U)","fit")
title ("I(U) characteristic");

%========== SHOW RESULTS

fit1
RSS1
CHI1

fit2
RSS2
CHI2

