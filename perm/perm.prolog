
%% permutation([], []).
%% permutation(L, [X|Xs]) :- select(X, L, Rest), permutation(Rest, Xs).

delete(X,[X|T],T).
delete(X,[Y|T],[Y|T1]):-delete(X,T,T1).

permute([],[]).
permute(L,[X|P]):-delete(X,L,L1),permute(L1,P).
    
greatest([X|T1],[Y|T2]):-X<Y.              
    
greatest([X|R1],[Y|R2]):-X<Y,greatest(R1,R2).

hp(N,N1):-permute(N,N1),greatest(N,N1).
            
nhp(N,N1):-hp(N,N1),hp(N,N2),greatest(N2,N1).
