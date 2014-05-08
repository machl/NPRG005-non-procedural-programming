--- 11. ukol - #1 (tautologie) ---
--- Petr Belohlavek ---

-- > jeTaut (Or (Prom 'a') (Not (Prom 'a')))
-- True
-- > jeTaut (And (Prom 'a') (Not (Prom 'a')))
-- False
-- > jeTaut (And (Or (Prom 'a') (Not $ Prom 'a')) (Not $ Konst False))
-- True

-- pri nastaveni PromType = String
-- > jeTaut (Or (Prom "ahoj") (Not $ Prom "ahoj"))
-- True


-- na mnoziny se odkazuje pres 'namespace' Set
import qualified Data.Set as Set

-- typedef, usetri trochu psani a zaruci vic typu promennych
type PromType = Char
-- type PromType = String
type PromSet = Set.Set PromType

-- formule ze zadani
data Formule = Konst Bool
             | Prom PromType
             | Not Formule
             | And Formule Formule
             | Or Formule Formule


-- vrati mnozinu promennych dane formule
promenne :: Formule -> PromSet
promenne (Konst _) = Set.empty
promenne (Prom c)  = Set.singleton c
promenne (Not f)   = promenne f
promenne (And f g) = Set.union (promenne f) (promenne g)
promenne (Or  f g) = Set.union (promenne f) (promenne g)

-- vrati seznam vsech podmnozin dane mnoziny
podmnoziny :: Ord a => Set.Set a -> [Set.Set a]
podmnoziny s | Set.size s == 0 = [Set.empty]
             | otherwise       = podmnoziny xs ++ map (Set.insert x) (podmnoziny xs)
                                 where (x, xs) = Set.deleteFindMin s

-- ohodnoti danou formuli ohodnocenim,
-- ohodnoceni je mnozina promennych, ktere se ohodnoti na True
ohodnot :: Formule -> PromSet -> Bool
ohodnot (Konst k) _        = k
ohodnot (Prom p)  pravdive = Set.member p pravdive
ohodnot (Not f)   pravdive = not $ ohodnot f pravdive
ohodnot (And f g) pravdive = (ohodnot f pravdive) && (ohodnot g pravdive)
ohodnot (Or f g)  pravdive = (ohodnot f pravdive) || (ohodnot g pravdive)

-- je formule tautologie?
jeTaut :: Formule -> Bool
jeTaut f = and $ map (ohodnot f) (podmnoziny $ promenne f)
