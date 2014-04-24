###
```
                                                | 
                                           1   |   3 
                                        ------------ 
                                       |            2  |  8 
                                    (10)       ------------
                                                 |               | 
                                              (15)          (5) 
 
```
na obrázku představují lanka, na nichž visí buďto objekt se zadanou váhou, nebo tyčka (označená jako ---),
na jejichž koncích jsou zavěšeny další "mobily". Čísla nad --- reprezentují délky jednotlivých ramen.

- mobil    ::= délka-lanka levé-rameno pravé-rameno
- rameno   ::= délka-ramena co-tam-visí
- délka-ramena  ::= číslo
- délka-lanka  ::= číslo 
- co-tam-visí   ::= mobil nebo číslo ( = váha zavěšeného objektu)

V jazyce Scheme
- (a) Definujte datovou strukturu pro reprezentaci takového prostorového mobilu.
- (b) Dva mobily jsou ekvivalentní, pokud lze jeden obdržet z druhého vhodnými rotacemi ramen.
Definujte binární funkci (predikát), který zjistí, zda jsou dva zadané mobily ekvivalentní.

