###spirala.prolog###

`spirala(+Matice,-Seznam)` :- Do seznamu poskládá prvky Matice tak, jak leží na spirále (Matice je seznam řádků, řádek je seznam prvků tohoto řádku).

```
?- spirala([[a,b,c],[d,e,f],[g,h,i]],X). 
X=[a,d,g,h,i,f,c,b,e]
```

Můžete předpokládat, že (obdélníková) matice je zadána korektně, tj. všechny "řádkové" seznamy mají stejnou délku.

###gen.prolog###
Definujte predikát `gen(+Seznam, +H, -Vyraz)`, který

obdrží seznam `N0,…,Nk`  a hodnotu `H`, obojí z množiny `{true,false}`
zjistí, zdali existuje seznam operátorů `op1,…,opk`  z množiny `{and,or}` takový, že (vhodně uzávorkovaný) výraz `N0 op1 N1op2… opk Nk` má hodnotu `H`
pokud taková posloupnost operátorů existuje, vrátí (postupně) všechny takové výrazy tvořené konstantami `true`, `false`, operátory `and`, `or` a závorkami
pokud taková posloupnost operátorů neexistuje, vrátí false

Příklad:
```
?- gen([true,false,true],true, V).
﻿V = true or false and true ;
V = true and (false or true) ;
V = true or (false or true) ;
V = true and false or true ;
V = (true or false)and true ;
V = true or false or true ;
false
```

```
?- gen([false,false],true, V).
false
```