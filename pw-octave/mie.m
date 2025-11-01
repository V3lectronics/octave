format short
C=[0.1 0.5 1 5 10 50 100];
f=[333.333, 285.710, 166.666, 425.5, 22.22, 4.55, 2.35];

disp("Farads");
C = C.*(10^(-9))

disp("Hertz");
f = f.*(10^(3))

disp("C * F")
Cf = C.*f

disp("Cf*3")
Cf = Cf.*3

disp("Cf*log2")
Cf = Cf.*log(2)

disp("1/Cf")
Cf = 1./Cf

disp("std u(R)")
selected = [Cf(7), Cf(6), Cf(5)]



% 1/(log(2)*3*Cf)
