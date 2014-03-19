%%% 5. ukol - #1 (spirala) %%%
%%% Petr Belohlavek %%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% El <- Pole[N]
nty_prvek([X|_], 1, X).
nty_prvek([_|Zbytek], N, El) :-
	N > 1,
	N1 is N-1,
	nty_prvek(Zbytek, N1, El).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% El <- Matice[X][Y]
prvek_x_y(Matice, X, Y, El) :-
	nty_prvek(Matice, X, Radek),
	nty_prvek(Radek, Y, El).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Vrati vsechno krome prvniho prvku pole
vyhod_prvni_prvek([_|Zbytek], Zbytek).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Vrati vsechno krome posledniho prvku matice
vyhod_posledni_prvek(Pole, []) :-
	length(Pole, L), L =< 1,
	!.
vyhod_posledni_prvek([Radek|Zbytek], [Radek|Dalsi]) :-
	vyhod_posledni_prvek(Zbytek, Dalsi),
	!.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Vrati vsechno krome prvniho sloupce matice
vyhod_prvni_sloupec([], []).
vyhod_prvni_sloupec([Radek|ZbytekMatice], [ZbytekRadku|Rekurzivne]) :-
	vyhod_prvni_prvek(Radek, ZbytekRadku),
	vyhod_prvni_sloupec(ZbytekMatice, Rekurzivne).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Vrati vsechno krome posledniho sloupce matice
vyhod_posledni_sloupec([], []).
vyhod_posledni_sloupec([Radek|ZbytekMatice], [ZbytekRadku|Rekurzivne]) :-
	vyhod_posledni_prvek(Radek, ZbytekRadku),
	vyhod_posledni_sloupec(ZbytekMatice, Rekurzivne).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%init
spirala([PrvniRadek|Zbytek], Pole) :-
	length([PrvniRadek|Zbytek], SizeX),
	length(PrvniRadek, SizeY),
	spirala([PrvniRadek|Zbytek], 1, 1, SizeX, SizeY, dolu, Pole),
	!.


% spodek
spirala(_,_,_,SizeX,SizeY,_,[]) :-
	SizeX = 0;
	SizeY = 0.

% dolu
spirala(Matice, X, Y, SizeX, SizeY, Smer, [El|Subpole]) :-
	Smer = dolu,
	X = SizeX,
	prvek_x_y(Matice, X, Y, El),
	vyhod_prvni_sloupec(Matice, NovaMatice),
	SizeY1 is SizeY - 1,
	spirala(NovaMatice, X, Y, SizeX, SizeY1, doprava, Subpole).

spirala(Matice, X, Y, SizeX, SizeY, Smer, [El|Subpole]) :-
	Smer = dolu,
	X < SizeX,
	prvek_x_y(Matice, X, Y, El),
	X1 is X+1,
	spirala(Matice, X1, Y, SizeX, SizeY, dolu, Subpole).

% doprava
spirala(Matice, X, Y, SizeX, SizeY, Smer, [El|Subpole]) :-
	Smer = doprava,
	Y = SizeY,
	prvek_x_y(Matice, X, Y, El),
	vyhod_posledni_prvek(Matice, NovaMatice),
	SizeX1 is SizeX - 1,
	X1 is X - 1,
	spirala(NovaMatice, X1, Y, SizeX1, SizeY, nahoru, Subpole).

spirala(Matice, X, Y, SizeX, SizeY, Smer, [El|Subpole]) :-
	Smer = doprava,
	Y < SizeY,
	prvek_x_y(Matice, X, Y, El),
	Y1 is Y+1,
	spirala(Matice, X, Y1, SizeX, SizeY, doprava, Subpole).

% nahoru
spirala(Matice, X, Y, SizeX, SizeY, Smer, [El|Subpole]) :-
	Smer = nahoru,
	X = 1,
	prvek_x_y(Matice, X, Y, El),
	vyhod_posledni_sloupec(Matice, NovaMatice),
	SizeY1 is SizeY - 1,
	Y1 is Y - 1,
	spirala(NovaMatice, X, Y1, SizeX, SizeY1, doleva, Subpole).

spirala(Matice, X, Y, SizeX, SizeY, Smer, [El|Subpole]) :-
	Smer = nahoru,
	X > 1,
	prvek_x_y(Matice, X, Y, El),
	X1 is X-1,
	spirala(Matice, X1, Y, SizeX, SizeY, nahoru, Subpole).

% doleva
spirala(Matice, X, Y, SizeX, SizeY, Smer, [El|Subpole]) :-
	Smer = doleva,
	Y = 1,
	prvek_x_y(Matice, X, Y, El),
	vyhod_prvni_prvek(Matice, NovaMatice),
	SizeX1 is SizeX - 1,
	%X1 is X - 1,
	spirala(NovaMatice, X, Y, SizeX1, SizeY, dolu, Subpole).

spirala(Matice, X, Y, SizeX, SizeY, Smer, [El|Subpole]) :-
	Smer = doleva,
	Y > 1,
	prvek_x_y(Matice, X, Y, El),
	Y1 is Y-1,
	spirala(Matice, X, Y1, SizeX, SizeY, doleva, Subpole).

% spirala([ [1,12,11], [2,13,10], [3,14,9], [4,15,8], [5,6,7] ], S).
