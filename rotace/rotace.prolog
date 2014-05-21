%% rotace v konstantim case
%% ?- rotace([1,2,3]-K, P-K).
%% K = [1|K],
%% P = [2, 3].
rotace(X - X       , X - X)  :- var(X).
rotace([X | Xs] - Y, Xs - Z) :- var(Y), Y = [X | Z].

