%%% 1. ukol - #2 (genealogie) %%%
%%% Petr Belohlavek %%%

%%%%%%% Fakta %%%%%%%
muz(ja).
muz(mujOtec).
muz(mujSyn).
muz(dcerinSyn).

zena(vdova).
zena(dcera).

manzele(ja, vdova).
manzele(mujOtec, dcera).

rodic(mujOtec, ja).
rodic(vdova, dcera).
rodic(ja, mujSyn).
rodic(vdova, mujSyn).
rodic(mujOtec, dcerinSyn).
rodic(dcera, dcerinSyn).

%%%%%%% Pravidla %%%%%%%
% Prvni je manezelem Druheho a naopak
partneri(Prvni, Druhy) :- manzele(Prvni, Druhy).
partneri(Prvni, Druhy) :- manzele(Druhy, Prvni).

% Ded je dedeckem Vnoucete
ndedecek(Ded, Vnouce) :- nrodic(R, Vnouce), nrodic(Ded, R), muz(Ded).

% Vnuk je vnukem Deda
nvnuk(Vnuk, Ded) :- nrodic(Ded, R), nrodic(R, Vnuk), muz(Vnuk).

% Ded je dedeckem Vnoucete
nvnuk(Ded, Vnouce) :- rodic(R, Vnouce), rodic(Ded, R), muz(Ded).

% Rod je nevlastnim rodicem Ditete
nrodic(Rod, Dit) :- rodic(Rod, Dit).
nrodic(Rod, Dit) :- partneri(Rod, P), rodic(P, Dit).

% Mat je nevlastni matkou Ditete
nmatka(Mat, Dit) :- nrodic(Mat, Dit), zena(Mat).

% Os a Sour jsou nevlastni sourozenci, tzn maji spolecneho nevlastniho rodice
nsourozenec(Os, Sour) :- nrodic(R, Os), nrodic(R, Sour).

% Os a Brat jsou nevlastnimi bratry
nbratr(Os, Brat) :- nsourozenec(Os, Brat), muz(Brat).

% Sv je nevlastním svagrem Os
nsvagr(Sv, Os) :- partneri(Os, P), nbratr(P, Sv).
nsvagr(Sv, Os) :- nsourozenec(Os, Sour), partneri(Sour, Sv).

% Zet je zetem Osoby
nzet(Zet, Os) :- muz(Zet), partneri(Zet, Manzelka), zena(Manzelka), nrodic(Os, Manzelka).

% Stryc je strycem Osoby
nstryc(Stryc, Os) :- nrodic(R, Os), nbratr(R, Stryc).

%%%%%%% Pravidve dotazy z pribehu %%%%%%%
% rodic(mujOtec, ja).
% rodic(vdova, dcera).
%
%%% ozenil jsem se %%%%
% manzele(ja, vdova).
% partneri(ja, vdova).
% partneri(vdova, ja).
% nrodic(ja, dcera).
%
%%% muj otec se ozenil s moji nevlastni dcerou %%%%
% manzele(mujOtec, dcera).
% partneri(mujOtec, dcera).
% partneri(mujOtec, dcera).
% nzet(mujOtec, ja).
% nmatka(dcera, ja).
%
%%% narodil se mi syn %%%
% nsvagr(mujSyn, mujOtec).
% nstryc(mujSyn, ja).
%
%%% me nevlastni dceri se narodil syn %%%
% nbratr(dcerinSyn, ja).
% nvnuk(dcerinSyn, ja).
% ndedecek(ja, ja).
