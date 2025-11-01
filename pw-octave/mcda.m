parametry = [
%auto   1     2     3     4
	50000 30000 45000 10000   ; %cena
	1     3     5     9       ; %wyglad 1-10
	4     7     7     3       ; %naprawialnosc 1-10
	5     5     2     7       ; %ilość miejsc
	50    100   200   90      ; %KM
	30    50    60    30      ; %bak
	50000 100000 300000 120000; %przebieg
	]

wagi = [
	0.8; %cena
	0.3; %wyglad
	0.5; %naprawialnosc
	0.5; %ilość miejsc
	0.6; %KM
	0.3; %bak
	0.7; %przebieg
]

%=============================================================
%=============================================================
%=============================================================

format short


function retval = mmnormalize(v, min_possible)
	retval = v - min_possible;
	retval = retval./ (max(v)-min_possible);
endfunction

function retval = invert(v)
	retval = v.^(-1);
endfunction

% parametry(1,:) = mmnormalize(parametry(1,:), 0)
parametry(1,:) = invert(parametry(1,:));
parametry(7,:) = invert(parametry(7,:));


for i = [1: size(parametry)(1) ]
	parametry(i,:) = mmnormalize( parametry(i,:), 0 ); %normalizacja
	parametry(i,:) = parametry(i,:).*wagi(i); %wagi
endfor

bar(mean(parametry))

parametry
mean(parametry)
