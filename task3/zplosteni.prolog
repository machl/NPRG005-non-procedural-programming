% zplosteni(+Strom, -Seznam)
% vezme Strom (seznam prvku pripadne dalsich seznamu)
% a zlinearizuje ho, tzn, vrati linearni seznam po
% sobe jdoucich prvku tak, jak by se strom prohledaval
% do hloubky, resp. ze zapisu odstrani vsechny hranate
% zavorky az na ty ohranicujici seznam
%
% priklad:
% ?- zplosteni([[a,b], [[c],[d,[e,f]]], [g], []], V).
% V = [a, b, c, d, e, f, g].
%
% problem:
% vraci i dalsi nesmyslne vysledky

zplosteni([], []).
zplosteni(Strom, Seznam) :- zplosteni(Strom, [], Seznam).

zplosteni([], Mezivysledek, Mezivysledek).
zplosteni([Prvni|Zbytek], Mezivysledek, Vysledek) :- zplosteni(Prvni, Mezivysledek, Mezivysledek2), zplosteni(Zbytek, Mezivysledek2, Vysledek).
zplosteni(Prvek, Mezivysledek, Vysledek) :- append(Mezivysledek, [Prvek], Vysledek).
