%%% 1. ukol - #3 (Einsteinova zebra) %%%
%%% Petr Belohlavek %%%

%%%%%%% problemy %%%%%%%
% - reseni/5 z nejakeho duvodu nevypise zebru, prestoze uz je reseni jednoznacne a zbyva na ni jedina volna pozice

%%%%%%% fakta %%%%%%%
% fakulty %
fakulta(mff).
fakulta(zcu).
fakulta(cvut).
fakulta(up).
fakulta(mu).

% napoje %
napoj(caj).
napoj(pivo).
napoj(biomleko).
napoj(vino).
napoj(kava).

% jazyky %
jazyk(prolog).
jazyk(scala).
jazyk(haskell).
jazyk(lisp).
jazyk(fsharp).

% barvy %
barva(cervena).
barva(zluta).
barva(zelena).
barva(oranzova).
barva(modra).

% zvirata %
zvire(pes).
zvire(papousek).
zvire(kocka).
zvire(kun).
zvire(zebra).

%%%%%%% pravidla %%%%%%%

% predikat dum / 5
% dum(Barva, Fakulta, Jazyk, Napoj, Zvire) - zarucuje, ze barva bude pravdu barva a ne treba zvire (atd)
dum(Barva, Fakulta, Jazyk, Napoj, Zvire) :- barva(Barva), fakulta(Fakulta), jazyk(Jazyk), napoj(Napoj), zvire(Zvire).

% predikat radaDomu / 5
% radaDomu(PrvniDum, DruhyDum, TretiDum, CtvrtyDum, PatyDum) - kolece 5 domu; zarucuje ruzne hodnoty napoju, barev atd.
radaDomu(
		dum(Barva1, Fakulta1, Jazyk1, Napoj1, Zvire1),
		dum(Barva2, Fakulta2, Jazyk2, Napoj2, Zvire2),
		dum(Barva3, Fakulta3, Jazyk3, Napoj3, Zvire3),
		dum(Barva4, Fakulta4, Jazyk4, Napoj4, Zvire4),
		dum(Barva5, Fakulta5, Jazyk5, Napoj5, Zvire5)
	) :- 
		Barva1 \= Barva2, Barva1 \= Barva3, Barva1 \= Barva4, Barva1 \= Barva5, Barva2 \= Barva3, Barva2 \= Barva4, Barva2 \= Barva5, Barva3 \= Barva4, Barva3 \= Barva5, Barva4 \= Barva5,
		Fakulta1 \= Fakulta2, Fakulta1 \= Fakulta3, Fakulta1 \= Fakulta4, Fakulta1 \= Fakulta5, Fakulta2 \= Fakulta3, Fakulta2 \= Fakulta4, Fakulta2 \= Fakulta5, Fakulta3 \= Fakulta4, Fakulta3 \= Fakulta5, Fakulta4 \= Fakulta5,
		Jazyk1 \= Jazyk2, Jazyk1 \= Jazyk3, Jazyk1 \= Jazyk4, Jazyk1 \= Jazyk5, Jazyk2 \= Jazyk3, Jazyk2 \= Jazyk4, Jazyk2 \= Jazyk5, Jazyk3 \= Jazyk4, Jazyk3 \= Jazyk5, Jazyk4 \= Jazyk5,
		Napoj1 \= Napoj2, Napoj1 \= Napoj3, Napoj1 \= Napoj4, Napoj1 \= Napoj5, Napoj2 \= Napoj3, Napoj2 \= Napoj4, Napoj2 \= Napoj5, Napoj3 \= Napoj4, Napoj3 \= Napoj5, Napoj4 \= Napoj5,
		Zvire1 \= Zvire2, Zvire1 \= Zvire3, Zvire1 \= Zvire4, Zvire1 \= Zvire5, Zvire2 \= Zvire3, Zvire2 \= Zvire4, Zvire2 \= Zvire5, Zvire3 \= Zvire4, Zvire3 \= Zvire5, Zvire4 \= Zvire5.

% predikat existuje / 2 lze definovat pomoci operatoru =
% existuje(D,RadaDomu):- Dum D je v RadaDomu.
existuje(D, radaDomu(D1, D2, D3, D4, D5)) :- D = D1; D = D2; D = D3; D = D4; D = D5.

% posicni predikaty / 3
% zaruci pozici domu D v radeDomu
prvni(D, radaDomu(D1, _, _, _, _)) :- D = D1.
prostredni(D, radaDomu(_, _, D3, _, _)) :- D = D3.
posledni(D, radaDomu(_, _, _, _, D5)) :- D = D5.

% predikat napravo / 3
% zaruci, ze Pravy dum je tesne napravo od Leveho domu (v rade domu Domy)
napravo(Pravy, Levy, radaDomu(D1, D2, _D3, _D4, _D5)) :- D1 = Levy, D2 = Pravy.
napravo(Pravy, Levy, radaDomu(_D1, D2, D3, _D4, _D5)) :- D2 = Levy, D3 = Pravy.
napravo(Pravy, Levy, radaDomu(_D1, _D2, D3, D4, _D5)) :- D3 = Levy, D4 = Pravy.
napravo(Pravy, Levy, radaDomu(_D1, _D2, _D3, D4, D5)) :- D4 = Levy, D5 = Pravy.

% predikat napravo / 3
% zaruci, ze Pravy dum je tesne napravo od Leveho domu (v rade domu Domy)
vedle(Prvni, Druhy, Domy) :- napravo(Prvni, Druhy, Domy); napravo(Druhy, Prvni, Domy).

% predikat reseni / 1
% vezme radu 5 domu a nastavi jim omezeni
reseni(Domy) :-
	% absolvent MFF programuje v Prologu
	existuje(dum(_, mff, prolog, _, _), Domy),

	% absolvent ZČU zije v cervenem dome
	existuje(dum(cervena, zcu, _, _, _), Domy),

	% absolvent ČVUT chova psa
	existuje(dum(_, cvut, _, _, pes), Domy),

	% absolvent UP pije caj
	existuje(dum(_, up, _, caj, _), Domy),

	% absolvent MU bydli v poslednim dome
	posledni(dum(_, mu, _, _, _), Domy),

	% programator v jazyce Scala pije pivo
	existuje(dum(_, _, scala, pivo, _), Domy),

	% obyvatel zluteho domu programuje v Haskellu
	existuje(dum(zluta, _, haskell, _, _), Domy),

	% programator v Lispu chova papouška
	existuje(dum(_, _, lisp, _, papousek), Domy),

	% obyvatel zeleneho domu pije biomleko
	existuje(dum(zelena, _, _, biomleko, _), Domy),

	% programator v Lispu bydli vedle chovatele kocky
	vedle(dum(_, _, lisp, _, _), dum(_, _, _, _, kocka), Domy),

	% chovatel kone bydli vedle programatora v Haskellu
	vedle(dum(_, _, _, _, kun), dum(_, _,haskell, _, _), Domy),

	% programator v F# ma souseda, který pije vino
	vedle(dum(_, _, fsharp, _, _), dum(_, _, _, vino, _), Domy),

	% zelený dum stoji (tesne) napravo od oranzoveho domu
	napravo(dum(zelena, _, _, _, _), dum(oranzova, _, _, _, _), Domy),

	% absolvent MU bydli vedle modreho domu
	vedle(dum(_, mu, _, _, _), dum(modra, _, _, _, _), Domy),

	% obyvatel prostredniho domu pije kavu
	prostredni(dum(_, _, _, kava, _), Domy).

% predikat clovek / 5
% najde ostatni atributy vyhovujici reseni - zkusi na kazdou pozici domu umistit dum vyhovujici zadanym podminkam.
% kdyz nenajde vraci false.
clovek(Barva, Fakul, Jazyk, Napoj, Zvire) :- 
	reseni(radaDomu(_, _, _, _, dum(Barva, Fakul, Jazyk, Napoj, Zvire)));
	reseni(radaDomu(_, _, _, dum(Barva, Fakul, Jazyk, Napoj, Zvire), _));
	reseni(radaDomu(_, _, dum(Barva, Fakul, Jazyk, Napoj, Zvire), _, _));
	reseni(radaDomu(_, dum(Barva, Fakul, Jazyk, Napoj, Zvire), _, _, _));
	reseni(radaDomu(dum(Barva, Fakul, Jazyk, Napoj, Zvire), _, _, _, _)).

%%%%%%% dotaz pro kompletni reseni %%%%%%%
% reseni(radaDomu(
% 	dum(Barva1, Fakul1, Jazyk1, Napoj1, Zvire1),
% 	dum(Barva2, Fakul2, Jazyk2, Napoj2, Zvire2),
% 	dum(Barva3, Fakul3, Jazyk3, Napoj3, Zvire3),
% 	dum(Barva4, Fakul4, Jazyk4, Napoj4, Zvire4),
% 	dum(Barva5, Fakul5, Jazyk5, Napoj5, Zvire5)
% )).

%%%%%%% najde cloveka chovajiciho zebru %%%%%%%
% clovek(B, F, J, N, zebra).
