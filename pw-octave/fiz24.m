disp("==================== SÓD")
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

lambda = 589.3 * 10^(-9);
ang = [0.2376562, 0.1178097, 0, 0.1178097, 0.2385289];
m = [2, 1, 0 , 1, 2];

x_mlambda = lambda .* m
y_sinang = sin(ang)

figure(1)
p1 = errorbar(B_x_I_Iconst, Uh_x_d_Iconst, uB_x_I_Iconst, uUh_x_d_Iconst, "~>");
set(p1, "linestyle", "none");
set(p1, "marker", "+");
set(gca, "linewidth", 4, "fontsize", 18);
xlabel ("lambda * m");
ylabel ("sin");
title ("Na");


