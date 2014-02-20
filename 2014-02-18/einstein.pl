
%Nápověda

% predikat dum / 5
% dum(Barva,Fakulta,Jazyk,Napoj,Zvire)

% predikat radaDomu / 5
% radaDomu(PrvniDum,DruhyDum,TretiDum,CtvrtyDum,PatyDum)

% predikat existuje / 2 lze definovat pomoci operatoru =
% existuje(D,RadaDomu):- Dum D je v RadaDomu.

%existuje(D,radaDomu(D1,D2,D3,D4,D5)):- D=D1; D=D2; D=D3; D=D4; D=D5.

%------------------------
% zatim nefunguje

fakulta(mff).
fakulta(zcu).
fakulta(cvut).
fakulta(up).
fakulta(mu).

napoj(caj).
napoj(pivo).
napoj(biomleko).
napoj(vino).
napoj(kava).

jazyk(prolog).
jazyk(scala).
jazyk(haskell).
jazyk(lisp).
jazyk(fsharp).

poradi(prvni).
poradi(druhy).
poradi(treti).
poradi(ctvrty).
poradi(paty).

barva(cervena).
barva(zluta).
barva(zelena).
barva(oranzova).
barva(modra).

zvire(pes).
zvire(papousek).
zvire(kocka).
zvire(kun).
zvire(zebra).

%------------------------

vedle(Kdo, Koho) :- nalevo(Kdo, Koho) ; napravo(Koho, Kdo).

% reseni(Fakulta, Napoj, Jazyk, Poradi, Barva, Zvire) :- .


%------------------------

fakulta_jazyk(mff, prolog).
fakulta_barva(zcu, cervena).
fakulta_zvire(cvut, pes).
fakulta_napoj(up, caj).
fakulta_poradi(mu, paty).
jazyk_napoj(scala, pivo).
barva_jazyk(zluta, haskell).
jazyk_zvire(lisp, papousek).
barva_napoj(zelena, biomleko).

% ??
% ??
% ??
napravo(zelena, oranzova).
% ??
poradi_napoj(treti, kava).

nalevo(prvni, druhy).
nalevo(druhy, treti).
nalevo(treti, ctvrty).
nalevo(ctvrty, paty).
