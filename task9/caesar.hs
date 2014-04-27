--- 9. ukol - #2 (ceasar) ---
--- Petr Belohlavek ---

import Data.Char

-- caesar n slovo - prevede slovo na ceaserovskou sifru s posunem n
-- funguje i na zaporna n
-- prevedi mala pismena, velka pismena a cislice
-- ostatni znaky necha jak jsou
-- pr:
---- > caesar 3 "Caesar123,.!?"
---- "Fdhvdu456,.!?"
---- > caesar (-3) "Fdhvdu456,.!?"
---- "Caesar123,.!?"
-- predpoklada, ze jednotlive abecedy a-z, A-Z, 0-9
---- jsou v kodovani tesne za sebou
caesar :: Int -> String -> String

-- prazdna slova jsou trivialni
caesar _ [] = []

-- slozena slova vzniknou rotaci prvniho znaku a rekurzivne se zbytekem slova
caesar n (x:xs) | (isLower x) = [chr (((((ord x) - (ord 'a')) + n) `mod` ((ord 'z') - (ord 'a') + 1)) + (ord 'a'))] ++ (caesar n xs)
                | (isUpper x) = [chr (((((ord x) - (ord 'A')) + n) `mod` ((ord 'Z') - (ord 'A') + 1)) + (ord 'A'))] ++ (caesar n xs)
                | (isDigit x) = [chr (((((ord x) - (ord '0')) + n) `mod` ((ord '9') - (ord '0') + 1)) + (ord '0'))] ++ (caesar n xs)
                | True        = [x] ++ (caesar n xs)
