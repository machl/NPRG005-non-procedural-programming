
%lshift([Head| Tail], [Tail| Head]).
lshift([X|XS], YS) :- append(XS, [X], YS).

rshift([], []).
rshift([X|XS], [Y,X|XS]) : - rshift(XS, [Y,YS]).

%posl(Seznam, PosledniPrvek, ZbytekSeznamu)
posl([X], X, []).
post([X|XS], Z, [X|YS]) :- posl(XS, Z, YS).

%palindrom
pal(S) :- reverse(S,S).

%nebo
pal(S) :- pal(S,[], S).
pal(S, Akumulator, Res).
