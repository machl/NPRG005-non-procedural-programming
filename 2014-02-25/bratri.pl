%%% 2. ukol - #3 (bratri) %%%
%%% Petr Belohlavek %%%

%%% fakta %%%
muz(adam).
muz(jan).
muz(petr).
muz(pavel).

zena(eva).
zena(anna). 

rodina(adam, eva, [anna, jan, petr, pavel]).
rodina(petr, anna, []).

%%% pravidla %%%

%%% Ze cviceni %%%

%prvek(X,Y) :- X lezi v Y
prvek(X, [X|_]).
prvek(X, [_|Y]) :- prvek(X, Y).

% vypust(X, Seznam, Vysledek) :- vyhodí vyskyt X ze Seznamu a ulozi Vysledek - nikdy neselze
vypust(_, [], []).
vypust(X, [X|T], T).
vypust(X, [Y|T], [Y|T1]) :- vypust(X,T,T1).

% vypust(X, Seznam, Vysledek) :- vyhodi vsechny vyskyty X ze Seznamu a ulozi Vysledek - nikdy neselze
vypust_vse(_, [], []).
vypust_vse(X, [X|T], Z) :- vypust_vse(X, T, Z).
vypust_vse(X, [H|T], [H|Z]) :- vypust_vse(X,T,Z).

%%% Ukol %%%

% bratri(?Bratri, +Koho) :- Bratri je seznam všech bratru Koho.
bratri(Bratri, Koho) :- rodina(_, _, Deti), prvek(Koho, Deti), vypust_vse(Koho, Deti, Sourozenci), pouze_muzi(Sourozenci, Bratri).

% pouze_muzi(Seznam, Muzi) :- vybere ze Seznamu pouze muze a ulozi je do Muzi
pouze_muzi([], []).
pouze_muzi([Os|Ostatni], [Os|ZbytekMuzu]) :- muz(Os), pouze_muzi(Ostatni, ZbytekMuzu).
pouze_muzi([Os|Ostatni], ZbytekMuzu) :- zena(Os), pouze_muzi(Ostatni, ZbytekMuzu).

% nejstarsibratr(?Kdo, +Koho) :- Kdo je nejstarším bratrem Koho.
% vybere vsechny bratry a z nich vezme nejstarsiho - tedy nejstarsi bratr (Kdo) muze byt mladsi nez Koho
nejstarsibratr(Kdo, Koho) :- bratri([Kdo|_], Koho), Kdo \= Koho, muz(Kdo).

% starsibratr(?Kdo, +Koho) :- Kdo je starším bratrem Koho.
starsibratr(Kdo, Koho) :- rodina(_, _, Deti), prvek(Koho, Deti), v_seznamu(Kdo, Koho, Deti), muz(Kdo).

% v_seznamu(Levy, Pravy, Seznam) :- Levy je v Seznamu (ostre) nalevo od Praveho
v_seznamu(Levy, Pravy, [Levy|Zbytek]) :- Levy \= Pravy, prvek(Pravy, Zbytek).
v_seznamu(Levy, Pravy, [_|Zbytek]) :- v_seznamu(Levy, Pravy, Zbytek).
