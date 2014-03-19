###aritm.prolog###
Aritmetika přirozených čísel je vybudována pomocí predikátu `nat/1` (viz cvičení #2). Definujte predikáty `exp/3`, `div/3` a `mod/3`:

###bratri.prolog###
Pokud se vám předchozí úloha nezamlouvá, můžete místo ní vyřešit následující: Jsou dány predikáty `muz/1`, `zena/1` a `rodina(Otec, Matka, Deti)`, kde `Deti` je seznam dětí od nejstaršího k nejmladšímu.

`muž(adam).	muž(jan).	muž(petr). muž(pavel). žena(eva). žena(anna). 
rodina(adam, eva, [jan, petr, pavel]).
rodina(petr, anna, []).
`

Definujte predikáty `starsibratr/2`, `nejstarsibratr/2` a `bratri/2`.