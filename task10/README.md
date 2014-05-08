### crack.hs

Prolomení Caesarovy šifry: Caesarovu šifru lze snadno prolomit, je-li šifrovaný text dostatečně dlouhý a jsou známy průměrné četnosti výskytu znaků v jazyce, v němž je text napsán. Metodu popsal již Edgar Allan Poe v klasické detektivní povídce Zlatý skarabeus.

Definujte funkci `crack :: String -> [Float] -> String`, která obdrží zašifrovaný text, tabulku očekávaných četností znaků v jazyce textu, a vrátí nejpravděpodobnější původní text. Při ladění můžete využít známé hodnoty očekávaných četností znaků [%] v anglickém či českém jazyce (jen 26 písmen bez diakritiky).

```
cetnostiEN :: [Float]
cetnostiEN = [8.2, 1.5, 2.8, 4.3, 12.7, 2.2, 2.0,
              6.1, 7.0, 0.2, 0.8, 4.0, 2.4, 6.7,
              7.5, 1.9, 0.1, 6.0, 6.3, 9.1, 2.8,
              1.0, 2.4, 0.2, 2.0, 0.1]
```

```
cetnostiCZ :: [Float]
cetnostiCZ = [8.6, 1.7, 3.3, 3.6, 10.5, 0.2, 0.2,
              2.2, 7.5, 2.2, 3.6, 4.2, 3.5, 6.8,
              8.0, 3.2, 0.0, 4.9, 6.3, 5.1, 4.0,
              4.3, 0.0, 0.1, 2.8, 3.2]
```
