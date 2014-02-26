%%% 2. ukol - #2 (aritmetika) %%%
%%% Petr Belohlavek %%%

%%% Ze cviceni %%%

% existuje naslednik 0, tzn 1
s(0).

% nat(X) :- X je prirozene cislo
nat(0).
nat(s(X)) :- nat(X).

% le(X, T) :- X <= T.
le(X, X) :- nat(X).
le(X, s(Y)) :- le(X, Y).

% lt(X, T) :- X < T
lt(X, s(X)) :- nat(X).
lt(X, s(T)) :- le(X, T).

% Vysledek <- X + Y
plus(0, X, X) :- nat(X).
plus(s(X), Y, s(Z)) :- plus(X, Y, Z).

%%% Ukol %%%

% Vysledek <- X - Y
minus(X, Y, Vysledek) :- plus(Y, Vysledek, X).

% Vysledek <- X * Y
times(0, X, 0) :- nat(X).
times(s(X), Y, Vysledek) :- times(X, Y, W), plus(W, Y, Vysledek).

% Vysledek <- X ^ N
exp(_, 0, s(0)).
exp(X, s(N), Vysledek) :- exp(X, N, W), times(X, W, Vysledek).

% Mod <- Delenec % Delitel
% zbytek po deleni
mod(Delenec, Delitel, Delenec) :- Delitel \= 0, lt(Delenec, Delitel).
mod(Delenec, Delitel, Mod) :- Delitel \= 0, minus(Delenec, Delitel, X), mod(X, Delitel, Mod).

% Div <- Delenec / Delitel
% celociselne deleni
div(Delenec, Delitel, Div) :- Delitel \= 0, mod(Delenec, Delitel, Mod), minus(Delenec, Mod, X), times(Delitel, Div, X).

%%% Testy %%%
% minus(s(s(s(0))), s(s(0)), V).
% minus(s(0), s(0), V).
% minus(0, 0, V).
% minus(0, s(0), V).
% minus(s(0), 0, V).
% minus(s(s(s(0))), 0, V).

% exp(0, 0, V).
% exp(s(0), s(0), V).
% exp(s(s(s(0))), s(0), V).
% exp(s(s(s(0))), 0, V).
% exp(s(s(0)), s(s(s(0))), V).

% mod(0, 0, V).
% mod(s(0), 0, V).
% mod(0, s(s(0)), V).
% mod(s(s(s(s(s(s(s(s(0)))))))), s(0), V).
% mod(s(s(s(s(s(s(s(s(0)))))))), s(s(s(0))), V).
% mod(s(s(s(s(s(s(s(s(0)))))))), s(s(s(s(s(s(s(0))))))), V).
% mod(s(s(s(s(s(s(s(s(0)))))))), s(s(s(s(s(s(s(s(0)))))))), V).

% div(0, 0, V).
% div(s(0), 0, V).
% div(0, s(s(0)), V).
% div(s(s(s(s(s(s(s(s(0)))))))), s(0), V).
% div(s(s(s(s(s(s(s(s(0)))))))), s(s(s(0))), V).
% div(s(s(s(s(s(s(s(s(0)))))))), s(s(s(s(s(s(s(0))))))), V).
% div(s(s(s(s(s(s(s(s(0)))))))), s(s(s(s(s(s(s(s(0)))))))), V).
