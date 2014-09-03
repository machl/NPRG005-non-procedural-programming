%% rotace v konstantim case
%% ?- rotace([1,2,3|K]-K, P-K).
%% K = [1|K],
%% P = [2, 3, 1|K].
rotace(X - X       , X - X)  :- var(X).
rotace([X | Xs] - Y, Xs - Z) :- var(Y), Y = [X | Z].

