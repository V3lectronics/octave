disp("=========")
pkg load statistics

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

xv = [
4.85101
5.01325
5.71033
5.93648
6.46104
6.89178
7.29422
7.58968
]
xv = xv .* 10^(14)

yUh = [
-0.64667
-0.69000
-0.96333
-1.02667
-1.25333
-1.44667
-1.59333
-1.69333
]

u_yUh = [
0.00123
0.00145
0.00282
0.00313
0.00427
0.00523
0.00597
0.00647
]

% p = lin_regression(xv, yUh);
% lin_regression_chi2(p, xv, yUh, u_yUh)
% ==================================================

u1_d618 = [
0
0.01
0.12
0.7
2.32
5.75
10.64
16.56
27.18
36.43
45.01
52.65
58.77
70.01
71.88
81.83
84.38
86.45
88.37
90.15
91.70
93.05
94.33
]
% u1_d618 = u1_d618 ./ 1000

i_d618 = u1_d618 ./ 100000

u2_d618 = [
-0.63
-0.6
-0.5
-0.4
-0.3
-0.2
-0.1
0
0.2
0.4
0.6
0.8
1
1.5
2
2.5
3
3.5
4
4.5
5
5.5
6
]

% ==================

u1_d598 = [
0
0
0.0002
0.0011
0.0032
0.0068
0.0116
0.0172
0.0278
0.0379
0.0468
0.0549
0.0623
0.0760
0.0842
0.0891
0.0921
0.0943
0.0961
0.0979
0.0995
0.1008
0.1020
]

u1_d598 = u1_d598 ./ 1000

i_d598 = u1_d598 ./ 100000

u2_d598 = [
-0.69
-0.6
-0.5
-0.4
-0.3
-0.2
-0.1
-0
0.2
0.4
0.6
0.8
1
1.5
2
2.5
3
3.5
4
4.5
5
5.5
6
]

R = 10^5
niep_R = 0.001
niep_u1_d618 = 0.0003 .* u1_d618 + 0.0002 * 0.5;
niep_u2_d618 = 0.0005 .* u2_d618 + 0.001 * 2; % 2 or 20
niep_id618 = sqrt( (1/R .* niep_u1_d618).^2 + (u1_d618 .* R^(-2) ).^2 ) 

niep_u1_d598 = 0.0003 .* u1_d598 + 0.0002 * 0.5;
niep_u2_d598 = 0.0005 .* u2_d598 + 0.001 * 2; % 2 or 20
niep_id598 = sqrt( (1/R .* niep_u1_d598).^2 + (u1_d598 .* R^(-2) ).^2 ) 

figure(1)
p1 = errorbar(u2_d618, i_d618, niep_u2_d618, niep_id618, "~>");
% axis ([x_lo x_hi y_lo y_hi])

% p1 = plot(B_x_I_Bconst, Uh_x_d_Bconst);
set(p1, "linestyle", "none");
set(p1, "marker", "+");
set(gca, "linewidth", 4, "fontsize", 18);
xlabel ("U2 [V]");
ylabel ("I [A]");
title ("Charakterystyki I(U) fotokomorki");


