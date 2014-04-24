Kódování Caesarovou šifrou.Caesarova šifra je název historické kryptografické metody,
kdy se všechna písmena ve zprávě cyklicky posunou o n pozic v abecedě dopředu.
Julius Caesar údajně používal tuto metodu s posunutím `n = 3`. Například slovo `CAESAR` by se zašifrovalo jako `FDHVDU`.

Definujte funkci `caesar :: Int -> String -> String` pro kódování i dekódování výše popsanou metodou.

Příklad:
```
> caesar 3 "Caesar" 
"Fdhvdu" 
> caesar (-3) "Fdhvdu" 
"Caesar"
```
