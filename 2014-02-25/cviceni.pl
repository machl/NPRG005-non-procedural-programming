
/*
%%% numerika

%nat(X) :- X € N
nat(0).
nat(s(X)) :- nat(X).

%le(X,T) :- X <= T.
le(X,X) :- nat(X).
le(X, s(Y)) :- le(X,Y).

%lt(X,Y) :- X < Y
lt(X, s(X)) :- nat(X).
lt(X, s(Y)) :- le(X,Y).

% lt(X,Y)  vypíše (0,1), (0,2) .. ale nikdy to nevypíše (1,*)
% DU:
% vygeneruj všechny dvojice X<Y

plus(0, X, X) :- nat(X).
plus(s(X), Y. s(Z)) :- plus (X, Y, Z).
minus(OdCeho, Kolik, Vysledek) :- plus(Kolik, Vysledek, OdCeho). %test it!

%minus(10, 7, V) V= 3;

times(0,X,0) : nat(X).
times(s(X), Y, Z) :- times(X,Y,W), plus(W,Y,Z).
times(s(X), Y, Z) :- plus(W,Y,Z), times(X,Y,W).

% seznamy
%[a,b,c] = [a|[b,c]] = [a,b|[c]]
%[]

prvek(X, [X|_]).
prvek(X, [_|Y]) :- prvek(X,Y).

vypust(_, [], []).
vypust(X, [X|T], T).
vypust(X, [Y|T], [Y|T1]) :- vypust(X,T,T1).

*/
% vyhodí všechny X a nikdy neselže
vypust_vse(_, [], []).
vypust_vse(X, [X|T], Z) :- vypust_vse(X, T, Z).
vypust_vse(X, [H|T], [H|Z]) :- vypust_vse(X,T,Z).

% vyhodí všechny X, ale pokud tam nejsou hodí FALSE
vypust_vse3(X, [X|T], Z) :- vypust_vse(X, T, Z).
vypust_vse3(X, [H|T], [H|Z]) :- vypust_vse3(X,T,Z).
