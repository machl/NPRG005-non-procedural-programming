
type Polynom = [Double]

polA = [1.0, 3.0, 0.0]                   -- 1 + 3x + 0x^2
polB = [0.0, 0.0, 1.0, 1.0, -6.0]        -- x^2 +  x^3 - 6x^4le
polC = [0.0, 0.0, 1.0, 4.0, -3.0, -18.0] -- x^2 + 4x^3 - 3x^4 - 18x^5

-- vyhazi zbytecne nuly na konci
-- pkanonizuj polA
pkanonizuj :: Polynom -> Polynom
pkanonizuj [] = []
pkanonizuj p  | last p == 0 = pkanonizuj $ init p
              | otherwise   = p

-- vynasobi polynom skalarem
-- 10 `pskal` polC
pskal :: Double -> Polynom -> Polynom
pskal u p = pkanonizuj $ map (*u) p

-- secte dva polynomy
-- polA `pplus` polB
pplus :: Polynom -> Polynom -> Polynom
pplus p q | length p < length q = pplus q p
          | otherwise           = pkanonizuj $ map (\ (i, j) -> i + j) (zip p (q ++ [0,0..]))

-- odecte dva polynomy
-- polA `pminus` polB
pminus :: Polynom -> Polynom -> Polynom
pminus p q = pkanonizuj $ p `pplus` ((-1) `pskal` q)

-- secte vsechny polynomy
-- psum [polA, polB, polC]
psum :: [Polynom] -> Polynom
psum p = pkanonizuj $ foldl pplus [] p

-- vynasobi dva polynomy
-- polA `pkrat` polB
pkrat :: Polynom -> Polynom -> Polynom
pkrat p q = psum $ map (\ (x, i) -> (take i [0,0..]) ++ (x `pskal` p)) (zip q [0..])

-- delni beze zbytku (zbytek kdo vi co udela) TODO: zbytky (easy as fuck)
-- polC `pdeleno` polA
pdeleno :: Polynom -> Polynom -> Polynom
pdeleno [] _ = []
pdeleno p  q = mezi `pplus` (pdeleno zbyva q)                              -- to co vyslo z jednoho kroku deleni + rekurzivne na zbytek
               where nejp  = last $ zip p [0..]                            -- clen s nejvyssi mocninou p
                     nejq  = last $ zip q [0..]                            -- clen s nejvyssi mocninou q
                     d     = (snd nejp) - (snd nejq)                       -- podelena mocnina
                     mezi  = (take d [0,0..]) ++ [(fst nejp) / (fst nejq)] -- mezivysledek, ktery se ma prictist
                     odec  = mezi `pkrat` q                                -- standardni skolni algoritmus - toto odecitame od p
                     zbyva = p `pminus` odec                               -- odecteme
