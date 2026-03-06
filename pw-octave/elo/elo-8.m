% czesc 2

n_180 = [
2830,
2750,
2690,
2670,
2520,
2480,
2470,
2440]

Mh_180 = [
0,
5,
10,
15,
20,
21,
22,
25]

I_180 = [
210,
210,
210,
215,
225,
230,
225,
235]

cos_phi_180 = [
0.5,
0.56,
0.62,
0.68,
0.75,
0.79,
0.78,
0.82]

n_200 = [
2620,
2590,
2570,
2540,
2520,
2500,
2480,
2450,
2390]

Mh_200 = [
3,
8,
13,
18,
23,
24,
25,
30,
40]

I_200 = [
235,
235,
235,
235,
240,
245,
250,
255,
275
]

cos_phi_200 = [
53,
58,
62,
67,
72,
75,
76,
80,
84]

cos_phi_200 = cos_phi_200 * 0.01;

figure(1);
hold on;
set(gca, "linewidth", 4, "fontsize", 8);
p1 = plot(Mh_180, n_180, 'r-');
p2 = plot(Mh_200, n_200, 'b-');
xlabel ("Mh [działki]");
ylabel ("n [obr/min]");
legend("Mh dla 180V","Mh dla 200V");
title ("n(Mh) dla 180V i 200V");
hold off;
saveas(gcf, 'cw8-1.png');

figure(2);
hold on;
set(gca, "linewidth", 4, "fontsize", 8);
p1 = plot(Mh_180, I_180, 'r-');
p2 = plot(Mh_200, I_200, 'b-');
xlabel ("Mh [działki]");
ylabel ("I [mA]");
legend("Mh dla 180V","Mh dla 200V");
title ("I(Mh) dla 180V i 200V");
hold off;
saveas(gcf, 'cw8-2.png');

figure(3);
hold on;
set(gca, "linewidth", 4, "fontsize", 8);
p1 = plot(Mh_180, cos_phi_180, 'r-');
p2 = plot(Mh_200, cos_phi_200, 'b-');
xlabel ("Mh [działki]");
ylabel ("cos phi");
legend("Mh dla 180V","Mh dla 200V");
title ("cos phi (Mh) dla 180V i 200V");
hold off;
saveas(gcf, 'cw8-3.png');


% czesc 3
Mh_150 = [
2,
7,
12,
17,
22,
27,
32,
37,
42,
32,
27,
22,
22,
22,
22,
]

n_150 = [
2370,
2300,
2330,
2310,
2280,
2250,
2210,
2180,
2040,
1850,
1575,
1530,
1030,
980,
900]

I_150 = [
95,
105,
110,
125,
135,
150,
170,
190,
230,
320,
320,
320,
320,
320,
320]

Mh_160 = [
4,
9,
14,
19,
24,
29,
35,
40,
45,
25,
20]

n_160 = [
2360,
2330,
2310,
2290,
2280,
2260,
2000,
2050,
1990,
1600,
1570]

I_160 = [
105,
110,
130,
140,
140,
160,
180,
190,
210,
360,
360]

figure(4);
hold on;
set(gca, "linewidth", 4, "fontsize", 8);
p1 = plot(Mh_150, n_150, 'r-');
p2 = plot(Mh_160, n_160, 'b-');
xlabel ("Mh [działki]");
ylabel ("n [obr/min]");
legend("Mh dla 150V","Mh dla 160V");
title ("n(Mh) dla 150V i 160V");
hold off;
saveas(gcf, 'cw8-4.png');

figure(5);
hold on;
set(gca, "linewidth", 4, "fontsize", 8);
p1 = plot(Mh_150, I_150, 'r-');
p2 = plot(Mh_160, I_160, 'b-');
xlabel ("Mh [działki]");
ylabel ("I [mA]");
legend("Mh dla 150","Mh dla 160");
title ("I(Mh) dla 150V i 160V");
hold off;
saveas(gcf, 'cw8-5.png');
