
% generuj_pole(+N, -Vysledek) :- pro dane cislo N vrati
%				seznam [1, 2, ..., N]
generuj_pole(1, [1]) :-
	number(N),
	!.

generuj_pole(N, Vysledek) :-
	N1 is N - 1,
	generuj_pole(N1, Sub),
	append(Sub, [N], Vysledek).


% veze(+N, -Souradnice) :- pro dane číslo N vrat postupne
%			vsechny seznamy souradnic (dvojic)
%			kam postavit N vezi tak, aby se na
%			sachovnici NxN neohrozovaly
veze(N, Souradnice) :-
	number(N),
	generuj_pole(N, Sloupce),
	veze(N, 1, Sloupce, Souradnice).

veze(N, N, [Sloupec], [N|Sloupec]) :- !.
veze(N, Radek, VolneSloupce, Vysledek) :-
	select(Sloupec, VolneSloupce, NoveSloupce),
	Radek1 is Radek + 1,
	veze(N, Radek1, NoveSloupce, Souradnice),
	append([[Radek|Sloupec]], [Souradnice], Vysledek).


% veze(8, Souradnice).
