Uh_Iconst = [
0.048
0.0426
0.0372
0.0313
0.0239
0.0183
0.0116
0.0049
0.0012
-0.0078
-0.0135
-0.0193
-0.025
-0.0311
-0.0365
-0.0419
-0.0471
];

Uh_Bconst = [
-0.0322
-0.0315
-0.0253
-0.0194
-0.0132
-0.0059
-0.0011
0.0085
0.0145
0.0202
0.0274
0.034
0.0401
];

B_Iconst = [
-0.32
-0.28
-0.24
-0.2
-0.16
-0.12
-0.08
-0.04
0.00 %zaokrągliłem zgodnie z resztą
0.04
0.08
0.12
0.16
0.2
0.24
0.28
0.32 ];

I_Bconst = [
0.03
0.025
0.02
0.01
0.015
0.005
0
-0.005
-0.01
-0.015
-0.02
-0.025
-0.03 ];

format short

% grubość płytki [m]
d = 0.001
ud = 0.0001/2 % z tabliczki (podzielić przez 2 bo to jest rozszerzona)
uI = 0.0005 % z tabliczki

% d = 1
% ud = 0.1

Bconst = 0.250
Iconst = 0.030

uB_Iconst = B_Iconst .* 0.02 % z tabliczki
uB_Bconst = Bconst .* 0.02 % z tabliczki

% B = CONST
Uh_x_d_Bconst = Uh_Bconst .* d							% y = Uh*d
B_x_I_Bconst = I_Bconst .* Bconst                                       	% x = B*I
uUh_Bconst = (Uh_Bconst.*0.005+0.4*0.001)/(sqrt(3))				% niepewność Uh
uUh_x_d_Bconst = ( (Uh_Bconst .* ud).^2 + (d * uUh_Bconst) ).^(0.5)		% niepewność y
uB_x_I_Bconst = ( (I_Bconst .* uB_Bconst).^2 + (Bconst .* uI).^2 ).^(0.5)       % niepewność x

% I = CONST
Uh_x_d_Iconst = Uh_Iconst .* d							% y = Uh*d
B_x_I_Iconst = B_Iconst .* Iconst						% x = B*I
uUh_Iconst = (Uh_Iconst.*0.005+0.4*0.001)/(sqrt(3))				% niepewność Uh
uUh_x_d_Iconst = ( (Uh_Iconst .* ud).^2 + (d * uUh_Iconst) ).^(0.5)		% niepewność y
uB_x_I_Iconst = ( (Iconst .* uB_Iconst).^2 + (B_Iconst .* uI).^2 ).^(0.5)	% niepewność x

% niepewność U*d JEST POMIJALNIE MAŁA w stosunku do B*I

%TODO złożyć z niepewnością d

% 1. Sporządzić wykresy zależności iloczynu napięcia Halla i grubości płytki od wartości iloczynu
% indukcji pola magnetycznego i natężenia prądu sterującego: (a) przy stałej wartości indukcji
% pola magnetycznego i (b) przy stałej wartości natężenia prądu. Punkty pomiarowe muszą
% posiadać odcinki niepewności.


figure(1)
p1 = errorbar(B_x_I_Bconst, Uh_x_d_Bconst, uB_x_I_Bconst, uUh_x_d_Bconst, "~>");
set(p1, "linestyle", "none");
set(p1, "marker", "+");
set(gca, "linewidth", 4, "fontsize", 18);
xlabel ("B*I [TA]");
ylabel ("U*d [V]");
title ("f(x) = Uh*d(B*I) dla B=const");
% hold on;
% plot(ch, fity, 'r-');
% legend("a(ch)","fit");
% hold off;
% plot(BconstI, Uh_Bconst)
% hold on;
% % plot(B)
% hold off;

figure(2)
p1 = errorbar(B_x_I_Iconst, Uh_x_d_Iconst, uB_x_I_Iconst, uUh_x_d_Iconst, "~>");
set(p1, "linestyle", "none");
set(p1, "marker", "+");
set(gca, "linewidth", 4, "fontsize", 18);
xlabel ("B*I [TA]");
ylabel ("U*d [V]");
title ("f(x) = Uh*d(B*I) dla I=const");
