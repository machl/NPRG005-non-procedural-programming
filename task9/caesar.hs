--- 9. ukol - #2 (ceasar) ---
--- Petr Belohlavek ---

import Data.Char

-- caesar n slovo
-- prevede slovo na ceaserovskou sifru s posunem n
-- funguje i na zaporna n
-- uvazuje se pouze na znaky [a-zA-z]
-- tedy abecedy jsou dlouhe 2x24
caesar :: Int -> String -> String

-- prazdna slova jsou trivialni
caesar n ([]) = []

-- na jednoznakovy string vrati jeho adekvatni posun
-- a vraci ho jako string
caesar n (x:[]) = [chr (((((ord x) - y) + n) `mod` 24) + y)]
        where y | (isLower x) = ord 'a'
                | (isUpper x) = ord 'A'
                | True = error "nepodporovany znak"

-- na viceznakove slovo se rekurzivne deli
caesar n (x:xs) = (caesar n [x]) ++ (caesar n xs)
