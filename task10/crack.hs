--- 10. ukol - #1 (crack) ---
--- Petr Belohlavek ---

import Data.Char

-- pro jednoducho umi pouze znaky [a-z]
-- velka pismena automaticky konvertuje na mala
-- ostatni znaky vcetne mezer a cislic se zahazuji
-- vetsina funkci pracuje s dvojici (i,A),
---- kde i je "o kolik rotuji" a A je nejaka hodnota
-- je dobre cist program "odspodu"

-- pr:
---- > caesar 7 "we hope you will maintain your membership and will encourage both the libraries you use and also other individuals to join membership conveys many benefits for you and for the wider academic community concerned for the understanding of medieval texts"
---- "dlovwlfvbdpssthpuahpufvbytltilyzopwhukdpsslujvbyhnlivaoaolspiyhyplzfvbbzlhukhszvvaolypukpcpkbhszavqvputltilyzopwjvuclfzthufilulmpazmvyfvbhukmvyaoldpklyhjhkltpjjvttbupafjvujlyulkmvyaolbuklyzahukpunvmtlkplchsaleaz"
---- > crack "dlovwlfvbdpssthpuahpufvbytltilyzopwhukdpsslujvbyhnlivaoaolspiyhyplzfvbbzlhukhszvvaolypukpcpkbhszavqvputltilyzopwjvuclfzthufilulmpazmvyfvbhukmvyaoldpklyhjhkltpjjvttbupafjvujlyulkmvyaolbuklyzahukpunvmtlkplchsaleaz" cetnostiEN 
---- "wehopeyouwillmaintainyourmembershipandwillencourageboththelibrariesyouuseandalsootherindividualstojoinmembershipconveysmanybenefitsforyouandforthewideracademiccommunityconcernedfortheunderstandingofmedievaltexts"

-- cetnostni mapa pro anglictinu
cetnostiEN :: [Float]
cetnostiEN = [8.2, 1.5, 2.8, 4.3, 12.7, 2.2, 2.0, 6.1, 7.0, 0.2, 0.8, 4.0, 2.4, 6.7, 7.5, 1.9, 0.1, 6.0, 6.3, 9.1, 2.8, 1.0, 2.4, 0.2, 2.0, 0.1]

-- cetnostni mapa pro cestinu
-- problem s nulami -> statistika vraci NaN
cetnostiCZ :: [Float]
cetnostiCZ = [8.6, 1.7, 3.3, 3.6, 10.5, 0.2, 0.2, 2.2, 7.5, 2.2, 3.6, 4.2, 3.5, 6.8, 8.0, 3.2, 0.0, 4.9, 6.3, 5.1, 4.0, 4.3, 0.0, 0.1, 2.8, 3.2]

-- jednoduchy caesar -> kanonizuje na [a-z] a potom sifruje
caesar :: Int -> String -> String
caesar n slovo = caesarRek n (kanonizuj slovo)
                 where caesarRek _ [] = []
                       caesarRek n (x:xs) = [chr (((((ord x) - (ord 'a')) + n) `mod` 26) + (ord 'a'))] ++ (caesarRek n xs)

-- prevede velka pismena na mala a nepismena odstrani
kanonizuj :: String -> String
kanonizuj [] = []
kanonizuj (x:xs) | isLower x = x : kanonizuj xs
                 | isUpper x = toLower x : kanonizuj xs
                 | otherwise = kanonizuj xs

-- inkrementuje i-tou pozici (indexovano od 0)
inc_i_th :: Int -> [Int] -> [Int]
inc_i_th i seznam = (take i seznam) ++ [(seznam!!i) + 1] ++ (drop (i+1) seznam)

-- dostane slovo a spocita cestnosti zbytku slova
cetnosti :: String -> [Int]
cetnosti slovo = cetnostiAk slovo (take 26 [0,0..])
                 where cetnostiAk [] cet     = cet
                       cetnostiAk (x:xs) cet = inc_i_th ((ord x) - (ord 'a')) (cetnostiAk xs cet)

-- spocita relativni cetnosti namerene v predanem slove
empiricke_cetnosti ::  (Int, String) -> (Int, [Float])
empiricke_cetnosti (i, slovo) = (i, map vydel_26 (cetnosti slovo))
                           where vydel_26 a = (fromIntegral a) / 26

-- dostane porovnavanou abecedu a seznam empirickych cestnosti
-- a vrati hodnotu statistiky
statistika :: [Float] -> (Int, [Float]) -> (Int, Float)
statistika oce (ind, emp) = (ind, sum (map (hodnota emp oce) [0,1..25]))
                     where hodnota e o i = (((e!!i) - (o!!i)) ** 2) / o!!i

-- dostane pole dvojice Rotace-Statistika a vrati dvojici s nejmensi statistikou
min_stat :: [(Int, Float)] -> (Int, Float)
min_stat [prvek] = prvek
min_stat (x:xs) = if (snd x) < (snd rek_min) then x
                  else rek_min
                  where rek_min = min_stat xs

-- vezme slovo a vrati seznam dvojic (i, caesar i slovo)
-- pro vsechna 0 <= i < 26
vsechny_rotace :: String -> [(Int, String)]
vsechny_rotace slovo = map (dvojice slovo) [0,1..25]
                         where dvojice s i = (i, (caesar i s))

-- vezme seznam dat a provede na nich statistiku
ohodnot_rotace :: [(Int, String)] -> [Float] -> [(Int, Float)]
ohodnot_rotace moznosti cetnostni_mapa = map (statistika cetnostni_mapa) (map empiricke_cetnosti moznosti)

-- vezme slovo a cetnostni mapu
-- a vrati nejpravdepodobnejsi desfirovane slovo
crack :: String -> [Float] -> String
crack slovo mapa = caesar n (kanonizuj slovo)
                   where n = fst (min_stat (ohodnot_rotace (vsechny_rotace (kanonizuj slovo)) mapa))
