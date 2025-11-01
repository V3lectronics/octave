parametry = [
	50000 30000 45000 10000; %cena
	1     3     5     9    ; %wyglad
	4     7     7     8    ; %naprawialnosc
	]

wagi = [
	0.8; %cena
	0.3; %wyglad
	0.5; %naprawialnosc
]

format short


function retval = mmnormalize(v, min_possible)
	retval = v - min_possible;
	retval = retval./ (max(v)-min_possible);
endfunction

function retval = invert(v)
	retval = v.^(-1);
endfunction


parametry(1,:) = mmnormalize(parametry(1,:), 0);
parametry(1,:) = invert(parametry(1,:));


for i = [1: size(parametry)(1) ]
	parametry(i,:) = mmnormalize( parametry(i,:), 0 ); %normalizacja
	parametry(i,:) = parametry(i,:).*wagi(i); %wagi
endfor

bar(mean(parametry))

parametry
mean(parametry)
