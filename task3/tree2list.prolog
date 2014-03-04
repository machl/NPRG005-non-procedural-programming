% stromNaSeznam(+Strom, -Seznam)
% vezme Strom (seznam prvku pripadne dalsich seznamu)
% a zlinearizuje ho, tzn, vrati linearni seznam po
% sobe jdoucich prvku tak, jak by se strom prohledaval
% do hloubky, resp. ze zapisu odstrani vsechny hranate
% zavorky az na ty ohranicujici seznam
%
% priklad:
% ?- stromNaSeznam([[a,b], [[c],[d,[e,f]]], [g], []], V).
% V = [a, b, c, d, e, f, g].
%
% problem:
% vraci i dalsi nesmyslne vysledky

stromNaSeznam([], []).
stromNaSeznam(Strom, Seznam) :- stromNaSeznam(Strom, [], Seznam).

stromNaSeznam([], Mezivysledek, Mezivysledek).
stromNaSeznam([Prvni|Zbytek], Mezivysledek, Vysledek) :- stromNaSeznam(Prvni, Mezivysledek, Mezivysledek2), stromNaSeznam(Zbytek, Mezivysledek2, Vysledek).
stromNaSeznam(Prvek, Mezivysledek, Vysledek) :- append(Mezivysledek, [Prvek], Vysledek).
