pkg install "https://github.com/gnu-octave/statistics/releases/download/release-1.7.5/statistics-1.7.5.tar.gz"

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

% format short e
format bank
matrix = [U, U_range, I, I_range]

% U_rms = rms(U)


% errorbar(X, Y, err)
figure (1);
errorbar(I, U, uU)
title ("U(I) characteristic");
xlabel ("I(A)");
ylabel ("U(V)");
annotation('textbox',[0.5 0.8, 0, 0],'string', sprintf('this is x: %f', x));

figure (2);
errorbar(U, I, uI)
title ("I(U) characteristic");
xlabel ("U(V)");
ylabel ("I(A)");

% figure (3);
% x = -10:0.1:10;
% plot (x, sin (x));
% title ("sin(x) for x = -10:0.1:10");
% xlabel ("x");
% ylabel ("sin (x)");
