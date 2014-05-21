--- 12. ukol - #1 (polynomy) ---
--- Petr Belohlavek ---

-- reprezenatace polynomu - seznam, kde
-- pol!!i == k      <==>     v polynomu je clen k*x^i
type Polynom = [Double]
polA = [1.0, 3.0, 0.0]                   -- 1 + 3x + 0x^2
polB = [0.0, 0.0, 1.0, 1.0, -6.0]        -- x^2 +  x^3 - 6x^4le
polC = [0.0, 0.0, 1.0, 4.0, -3.0, -18.0] -- x^2 + 4x^3 - 3x^4 - 18x^5
polD = [2.0, 0.0, 1.0, 4.0, -3.0, -18.0] -- 2 + x^2 + 4x^3 - 3x^4 - 18x^5

-- vyhazi zbytecne nuly na konci
-- > pkanonizuj polA
pkanonizuj :: Polynom -> Polynom
pkanonizuj [] = []
pkanonizuj p  | last p == 0 = pkanonizuj $ init p
              | otherwise   = p

-- vynasobi polynom skalarem
-- > 10 `pskal` polC
pskal :: Double -> Polynom -> Polynom
pskal u p = pkanonizuj $ map (*u) p

-- secte dva polynomy
-- > polA `pplus` polB
pplus :: Polynom -> Polynom -> Polynom
pplus p q | length p < length q = pplus q p
          | otherwise           = pkanonizuj $ map (\ (i, j) -> i + j) (zip p (q ++ [0,0..]))

-- odecte dva polynomy
-- > polA `pminus` polB
pminus :: Polynom -> Polynom -> Polynom
pminus p q = pkanonizuj $ p `pplus` ((-1) `pskal` q)

-- secte vsechny polynomy
-- > psum [polA, polB, polC]
psum :: [Polynom] -> Polynom
psum ps = pkanonizuj $ foldl pplus [] ps

-- vynasobi dva polynomy
-- > polA `pkrat` polB
pkrat :: Polynom -> Polynom -> Polynom
pkrat p q = psum $ map (\ (x, i) -> (take i [0,0..]) ++ (x `pskal` p)) (zip q [0..])

-- vydeli prvni polynom druhym
-- > polC `pdeleno` polA
-- > polD `pdeleno` polA
pdeleno :: Polynom -> Polynom -> (Polynom, Polynom)
pdeleno p q | kanq == []                = error "Deleni nulou"                          -- deleni prazdnym polynomem (nulou)
            | kanp == []                = ([], [])                                      -- trivialni deleni prazdneoho polynomu
            | length kanp < length kanq = ([], kanp)                                    -- uz neni co delit, vrati zbytek
            | otherwise                 = (mezi `pplus` (fst rekur), snd rekur)         -- to co vyslo z jednoho kroku deleni + rekurzivne na zbytek
                        where kanp      = pkanonizuj p                                  -- kanonizovane p
                              kanq      = pkanonizuj q                                  -- kanonizovane q
                              nejp      = last $ zip kanp [0..]                         -- clen s nejvyssi mocninou p
                              nejq      = last $ zip kanq [0..]                         -- clen s nejvyssi mocninou q
                              d         = (snd nejp) - (snd nejq)                       -- podelena mocnina
                              mezi      = (take d [0,0..]) ++ [(fst nejp) / (fst nejq)] -- mezivysledek, ktery se ma prictist
                              odec      = mezi `pkrat` kanq                             -- standardni skolni algoritmus - toto odecitame od p
                              zbyva     = kanp `pminus` odec                            -- odecteme
                              rekur     = zbyva `pdeleno` kanq                          -- rekurzivne se spusti na zbytek
