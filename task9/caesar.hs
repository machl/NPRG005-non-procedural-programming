--- 9. ukol - #2 (ceasar) ---
--- Petr Belohlavek ---

import Data.Char

-- caesar n slovo
-- prevede slovo na ceaserovskou sifru s posunem n
-- funguje i na zaporna n
-- pismenne abecedy jsou dlouhe 2x24
-- cislicova abeceda je dlouha 10
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
caesar n ([]) = []

-- na jednoznakovy string vrati jeho adekvatni posun
-- a vraci ho jako string
-- nepouziva shift, ale vlastnosti modulo aritmetiky
---- m := delka posunovane abecedy
---- y := offset abecedy
---- z := v pripade neposunovaneho znaku anuluje efekt y
caesar n (x:[]) = [chr (((((ord x) - y) + n) `mod` m) + y - z)]
        where y | (isLower x) = ord 'a'
                | (isUpper x) = ord 'A'
                | (isDigit x) = ord '0'
                | True = n

              m | (isAlpha x) = 24
                | (isDigit x) = 10
                | True = 9999999

              z | ((isAlpha x) || (isDigit x)) = 0
                | True = y

-- na viceznakove slovo se rekurzivne deli
caesar n (x:xs) = (caesar n [x]) ++ (caesar n xs)
