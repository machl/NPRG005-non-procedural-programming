%% Haskell-like map
%% map(+F, +Input, ?Output) :- Output is list of F results applied on Input
map(_, [], []) :- !.
map(F, [I|Ix], [O|Ox]):-
	Handle =.. [F, I, O],
	call(Handle),
	map(F, Ix, Ox).

%% sample
times2(A, B) :- B is A * 2.

%% ?- map(times2, [1,2,3], Res).
%% Res = [2, 4, 6].
%% 
%% ?- map(times2, [1,2,3], [2,4,6]).
%% true.
%% 
%% ?- map(times2, [1,2,3], [2,4,7]).
%% false.
%% 
%% ?- map(times2, [1,2,3], [2,8,6]).
%% false.
