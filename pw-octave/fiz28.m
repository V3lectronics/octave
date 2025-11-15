
%  =========================================
%  ======== DATA PREPARATION ===============
%  =========================================

disp('=========')

pkg load statistics
format short
h=0.0998;
c = [20   40   80   120   160];
a = [1.54 2.76 5.51 7.67 9.92];


ch = c.*h;

% to radians
a = a .* (pi/180);

% transpose
a = a'
ch = ch'

% F = [ones(size(ch)), ch];   % design matrix with intercept

% =========================================
% ======== STATISTICS =====================
% =========================================



%  y=a
%  x=ch
%
%  gamma = ch/a
%
%  CI = Estimate ± 1.96×Standard Error,
%  Standard Error = (CI - Estimate)/1.96
%
%  z=1.96 is the critical value from the standard normal distribution corresponding to a 95% confidence level in a two-tailed test.


% PW fiz lab style std dev
function retval = std_dev(v)
	n = length(v);
	expected = mean(v);
	sum_sq_res = sum((v-expected).^2);
	retval = ( ( 1/( n*(n-1) ) ) * sum_sq_res )^(0.5);
endfunction

% PW style chi2 statistic for testing linear goodness of fit
function retval = chi2(y_observed, y_fitted, y_uncertainty)
	% chi2 = sum(((y - y_fit).^2) ./ (u_y.^2));
	retval = sum( y_uncertainty.^(-2) .* (y_observed - y_fitted).^2 );
endfunction

% get critial chi2 value
function retval = chi2_crit(alpha, dof)
	retval = chi2inv(1 - alpha, dof);
endfunction


% a_type_A_stderr = std_dev(a)
% ch_type_A_stderr = std_dev(ch)

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
endfunction

lin_regression(ch)


disp("/////// std errors ////////")
a_type_B_stderr = 0.041
ch_type_B_stderr = 0.060
a1avg = a(1);
ch1 = ch(1);

% niepewność złożona B
gamma_type_B_stderr = ( ( (1/ch1)*a_type_B_stderr )^2 + ( ( a1avg/(ch1^2) )*ch_type_A_stderr )^2 )^(0.5)

% niepewność A z metody kwadratów
gamma_type_A_stderr = slope_stderr

% całkowita
gamma_total_stderr = mat2str( (gamma_type_B_stderr^2 + gamma_type_A_stderr^2)^(0.5), 2)

function = lin_regression_chi2(p) % p is the output of linear regression
	disp("/////// CHI2 ////////")
	fity = p(2)*ch + p(1);
	CHI2 = chi2(a, fity, a_type_B_stderr)
	degs_of_freedom = length(a)-2
	CHI2_crit = chi2_crit(0.05, degs_of_freedom)

	if (CHI2 < CHI2_crit)
		disp("brak podstaw do odrzucenia hipotezy o liniowości")
	else
		disp("należy odrzucić hipotezę o liniowości"
	endif
endfunction

lin_regression_chi2(p)


% =========================================
% ============== PLOT =====================
% =========================================


figure(1)
p1 = errorbar(ch, a, a_type_B_stderr);
set(p1, "linestyle", "none");
set(p1, "marker", "+");
set(gca, "linewidth", 4, "fontsize", 18);
xlabel ("ch [kg/m2]");
ylabel ("alpha [rad]");
hold on;

plot(ch, fity, 'r-');

legend("a(ch)","fit");
title ("a(ch) plot");

hold off;


