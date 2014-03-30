%%% 6. ukol - #1 (lidojedi) %%%
%%% Petr Belohlavek %%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Pouze verze s jednou rekou
%
% Stavy jsou reprezentovany petici s(M_p, L_p, M_l, L_l, Strana), kde
%	M_p = pocet misionaru na pravem brehu reky
%	L_p = pocet lidojedu na pravem brehu reky
%	M_l = pocet misionaru na levem brehu reky
%	L_l = pocet lidojedu na levem brehu reky
%	Strana = {prava|leva} - udava aktualni pozici lodky
%
% Predikat lidojedi prohledava stavovy prostor jako v priklade s vodou na cviceni.
% Postupne vola predikat prevez a kontroluje, zda nekde neni vic lidojedu nez misionaru
%
% Predikat prevez zkousi pro kazdou pozici lodky nasledujici (pokud je to mozne) a zmeni pozici lodky:
%	preveze jenom jednoho cloveka (1 lidojed XOR 1 misionar)
%	preveze dva stejne lidi (2 lidojedy XOR 2 misionare)
%	preveze dva ruzne lidi (1 lidojed AND 1 misionar)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% prevazime jednoho cloveka %%%

% prevez pouze jednoho misionare zprava doleva
prevez(s(M_p, L_p, M_l, L_l, prava), s(Novy_M_p, L_p, Novy_M_l, L_l, leva)) :-
	M_p > 0,
	Novy_M_p is M_p - 1,
	Novy_M_l is M_l + 1.

% prevez pouze jednoho misionare zleva doprava
prevez(s(M_p, L_p, M_l, L_l, leva), s(Novy_M_p, L_p, Novy_M_l, L_l, prava)) :-
	M_l > 0,
	Novy_M_l is M_l - 1,
	Novy_M_p is M_p + 1.

% prevez pouze jednoho lidojeda zprava doleva
prevez(s(M_p, L_p, M_l, L_l, prava), s(M_p, Novy_L_p, M_l, Novy_L_l, leva)) :-
	L_p > 0,
	Novy_L_p is L_p - 1,
	Novy_L_l is L_l + 1.

% prevez pouze jednoho lidojeda zleva doprava
prevez(s(M_p, L_p, M_l, L_l, leva), s(M_p, Novy_L_p, M_l, Novy_L_l, prava)) :-
	L_l > 0,
	Novy_L_l is L_l - 1,
	Novy_L_p is L_p + 1.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% prevazime dva stejne lidi %%%

% prevez dva misionare zprava doleva
prevez(s(M_p, L_p, M_l, L_l, prava), s(Novy_M_p, L_p, Novy_M_l, L_l, leva)) :-
	M_p > 1,
	Novy_M_p is M_p - 2,
	Novy_M_l is M_l + 2.

% prevez dva misionare zleva doprava
prevez(s(M_p, L_p, M_l, L_l, leva), s(Novy_M_p, L_p, Novy_M_l, L_l, prava)) :-
	M_l > 1,
	Novy_M_l is M_l - 2,
	Novy_M_p is M_p + 2.

% prevez dva lidojedy zprava doleva
prevez(s(M_p, L_p, M_l, L_l, prava), s(M_p, Novy_L_p, M_l, Novy_L_l, leva)) :-
	L_p > 1,
	Novy_L_p is L_p - 2,
	Novy_L_l is L_l + 2.

% prevez dva lidojedy zleva doprava
prevez(s(M_p, L_p, M_l, L_l, leva), s(M_p, Novy_L_p, M_l, Novy_L_l, prava)) :-
	L_l > 1,
	Novy_L_l is L_l - 2,
	Novy_L_p is L_p + 2.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% prevazime dva ruzne lidi %%%

% prevez pouze jednoho misionare a jednoho lidojeda zprava doleva
prevez(s(M_p, L_p, M_l, L_l, prava), s(Novy_M_p, Novy_L_p, Novy_M_l, Novy_L_l, leva)) :-
	M_p > 0,
	L_p > 0,
	Novy_M_p is M_p - 1,
	Novy_L_p is L_p - 1,
	Novy_M_l is M_l + 1,
	Novy_L_l is L_l + 1.

% prevez pouze jednoho misionare  a jednoho lidojeda zleva doprava
prevez(s(M_p, L_p, M_l, L_l, leva), s(Novy_M_p, Novy_L_p, Novy_M_l, Novy_L_l, prava)) :-
	M_l > 0,
	L_l > 0,
	Novy_M_l is M_l - 1,
	Novy_L_l is L_l - 1,
	Novy_M_p is M_p + 1,
	Novy_L_p is L_p + 1.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% M misionaru a L lidojedu na prave strane reky
% do Reseni unifikujeme seznam stavu potrebny pro prevoz
lidojedi(M, L, Reseni) :-
	number(M),
	number(L),
	lidojedi(s(M, L, 0, 0, prava), [s(M, L, 0, 0, prava)], Stavy),
	reverse(Stavy, Reseni), !.

% M_p, L_p vpravo
% M_l, L_l vlevo
% kdyz uz nikdo neni vpravo, mame reseni, protoze jsou vsichni vlevo
lidojedi(s(M_p, L_p, _, _, _), Stavy, Stavy) :-
	M_p = 0,
	L_p = 0, !.

% pro dany stav a Prohledany stavovy prostor pridame dalsi prohledani
lidojedi(s(M_p, L_p, M_l, L_l, Lod), Navstiveno, S) :-

	prevez(s(M_p, L_p, M_l, L_l, Lod), s(Novy_M_p, Novy_L_p, Novy_M_l, Novy_L_l, Nova_Lod)),

	(Novy_M_p = 0 ; Novy_M_p >= Novy_L_p),
	(Novy_M_l = 0 ; Novy_M_l >= Novy_L_l),

	\+member(s(Novy_M_p, Novy_L_p, Novy_M_l, Novy_L_l, Nova_Lod), Navstiveno),
	lidojedi(s(Novy_M_p, Novy_L_p, Novy_M_l, Novy_L_l, Nova_Lod), [s(Novy_M_p, Novy_L_p, Novy_M_l, Novy_L_l, Nova_Lod)|Navstiveno], S).
