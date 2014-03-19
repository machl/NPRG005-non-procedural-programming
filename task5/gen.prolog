%%% 5. ukol - #2 (gen) %%%
%%% Petr Belohlavek %%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% Formule vyrokoveho poctu %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- op(200,  fy, non).
:- op(210, yfx, and).
:- op(215, xfx, xor).
:- op(220, yfx, or).
:- op(230, xfy, imp).
:- op(240, xfx, ekv).


% je_fvp(+F) :- F je spravne utvorena formule vyrokoveho poctu.
je_fvp(true). je_fvp(false). je_fvp(p(_)).
je_fvp(non A) :- je_fvp(A).
je_fvp(A and B) :- je_fvp(A), je_fvp(B).
je_fvp(A or B) :- je_fvp(A), je_fvp(B).
je_fvp(A imp B) :- je_fvp(A), je_fvp(B).
je_fvp(A ekv B) :- je_fvp(A), je_fvp(B).

% eval(+F,?S,?H) :- H je hodnota formule F v interpretaci jejich promennych dane seznamem S.
eval(true,_,true).
eval(false,_,false).
eval(p(X),S,H) :- member(X-H,S),!.
eval(non F,S,H) :- eval(F,S,HF), eval_non(HF,H).
eval(F and G,S,H) :- eval(F,S,HF), eval(G,S,HG), eval_and(HF,HG,H).
eval(F or G,S,H) :- eval(F,S,HF), eval(G,S,HG), eval_or(HF,HG,H).
eval(F imp G,S,H) :- eval(non F or G, S, H).
eval(F ekv G,S,H) :- eval(F, S, HF), eval(G, S, HG), 
                     eval(HF and HG or non HF and non HG, S, H).

% pomocne predikaty pro vyhodnocení spojek
eval_non(true, false).
eval_non(false, true).

eval_and(true,true,true).
eval_and(false,_,false).
eval_and(true,false,false).

eval_or(false,false,false).
eval_or(true,_,true).
eval_or(false,true,true).

% sat(+Formule):- formule F je splnitelna, tj. nabyva hodnoty pravda pro nejake pravdivostní hodnoty svych promennych
sat(F) :- eval(F,_,true).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% gen %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
gen([X], X, X).
gen(Seznam, Hodnota, Vysledek) :-
	append(Levy, Pravy, Seznam),

	Levy \= [],
	Pravy \= [],

	gen(Levy, Rl, Vl),
	gen(Pravy, Rr, Vp),
	((
		eval_and(Rl, Rr, Hodnota),
		Vysledek =.. [and, Vl, Vp]
	);(
		eval_or(Rl, Rr, Hodnota),
		Vysledek =.. [or, Vl, Vp]
	)).


% přiklady:
% ?- gen([true,false,true],true, V).
% ﻿V = true or false and true ;
% V = true and (false or true) ;
% V = true or (false or true) ;
% V = true and false or true ;
% V = (true or false)and true ;
% V = true or false or true ;
% false
% 
% ?- gen([false,false],true, V).
% false