### taut.hs

Výrokový počet v jazyce Haskell. Datový typ pro reprezentaci formulí výrokového počtu lze v jazyce Haskell definovat např. takto:

```
data Formule = Konst Bool
             | Prom Char
             | Not Formule
             | And Formule Formule
             | Or Formule Formule
```

Definujte funkci `jeTaut :: Formule -> Bool`, která zjistí, zdali je zadaná formule výrokového počtu tautologií.
