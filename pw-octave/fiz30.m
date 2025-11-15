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
pkg load statistics

% grubość płytki [m]
d = 0.001
ud = 0.0001/2 % z tabliczki (podzielić przez 2 bo to jest rozszerzona)
uI = 0.0005 % z tabliczki


Bconst = 0.250
Iconst = 0.030

% fake dane
% d = 1
% ud = 0.1
% Bconst = 250
% Iconst = 030

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

% 2. Obliczyć stałą Halla metodą najmniejszej sumy kwadratów przy użyciu programu Origin.
% Sprawdzić wartość testu χ2 dla otrzymanych prostych. Wyznaczyć niepewność typu B
% i niepewność złożoną stałej Halla.

% [p, p_int, r, r_int, stats] = regress(a, F);
%
% intercept = p(1)
% slope = p(2)
% lower_bound_ci_intercept = p_int(1,1)
% upper_bound_ci_intercept = p_int(1,2)
% lower_bound_ci_slope = p_int(2,1)
% upper_bound_ci_slope = p_int(2,2)
%
% intercept_stderr = (upper_bound_ci_intercept - intercept) / 1.96
% slope_stderr = (upper_bound_ci_slope - slope) / 1.96
%
% R2 = stats(1)


% PW style chi2 statistic for testing linear goodness of fit
function retval = chi2(y_observed, y_fitted, y_uncertainty)
	% chi2 = sum(((y - y_fit).^2) ./ (u_y.^2));
	retval = sum( y_uncertainty.^(-2) .* (y_observed - y_fitted).^2 );
endfunction

% get critial chi2 value
function retval = chi2_crit(alpha, dof)
	retval = chi2inv(1 - alpha, dof);
endfunction


function retval = lin_regression(x, y)
	disp("/////// LIN REG ////////")
	F = [ones(size(x)), x];   % design matrix with intercept

	[p, p_int, r, r_int, stats] = regress(y, F);

	intercept = p(1)
	slope = p(2)
	lower_bound_ci_intercept = p_int(1,1)
	upper_bound_ci_intercept = p_int(1,2)
	lower_bound_ci_slope = p_int(2,1)
	upper_bound_ci_slope = p_int(2,2)

	% intercept_stderr = abs(lower_bound_ci_intercept-upper_bound_ci_intercept)/(2*1.96)
	intercept_stderr = (upper_bound_ci_intercept - intercept) / 1.96
	slope_stderr = (upper_bound_ci_slope - slope) / 1.96

	R2 = stats(1)

	retval = p;
endfunction


function lin_regression_chi2(p, x, y, y_err)
% p is the output of regress()
	disp("/////// CHI2 ////////")
	fity = p(2)*x + p(1);
	CHI2 = chi2(y, fity, y_err)
	degs_of_freedom = length(y)-2
	CHI2_crit = chi2_crit(0.05, degs_of_freedom)

	if (CHI2 < CHI2_crit)
		disp("brak podstaw do odrzucenia hipotezy o liniowości")
	else
		disp("należy odrzucić hipotezę o liniowości")
	endif
endfunction



disp("")
disp("=======B CONST========")

p_Bconst = lin_regression(B_x_I_Bconst, Uh_x_d_Bconst);
lin_regression_chi2(p_Bconst, B_x_I_Bconst, Uh_x_d_Bconst, uUh_x_d_Bconst)
fity_Bconst = p_Bconst(2)*B_x_I_Bconst + p_Bconst(1);

figure(1)
p1 = errorbar(B_x_I_Bconst, Uh_x_d_Bconst, uB_x_I_Bconst, uUh_x_d_Bconst, "~>");
% p1 = plot(B_x_I_Bconst, Uh_x_d_Bconst);
set(p1, "linestyle", "none");
set(p1, "marker", "+");
set(gca, "linewidth", 4, "fontsize", 18);
xlabel ("B*I [TA]");
ylabel ("U*d [V]");
title ("f(x) = Uh*d(B*I) dla B=const");

hold on;
plot(B_x_I_Bconst, fity_Bconst, 'r-');
% plot(0, p_Bconst(1), 'ro', 'MarkerSize', 10); % intercept point in red circle

% legend("a(ch)","fit");
hold off;

disp("")
disp("=======I CONST========")

p_Iconst = lin_regression(B_x_I_Iconst, Uh_x_d_Iconst);
lin_regression_chi2(p_Iconst, B_x_I_Iconst, Uh_x_d_Iconst, uUh_x_d_Iconst)
fity_Iconst = p_Iconst(2)*B_x_I_Iconst + p_Iconst(1);

figure(2)
p1 = errorbar(B_x_I_Iconst, Uh_x_d_Iconst, uB_x_I_Iconst, uUh_x_d_Iconst, "~>");
set(p1, "linestyle", "none");
set(p1, "marker", "+");
set(gca, "linewidth", 4, "fontsize", 18);
xlabel ("B*I [TA]");
ylabel ("U*d [V]");
title ("f(x) = Uh*d(B*I) dla I=const");

hold on;
plot(B_x_I_Iconst, fity_Iconst, 'r-');
% legend("a(ch)","fit");
hold off;

