
import Data.List

perms :: Eq a => [a] -> [[a]]
perms [] = [[]]
perms xs = [x:ys | x <- xs, ys <- perms (filter (/=x) xs)]

condPerm :: Eq a => [a] -> [(a,a)] -> [[a]]
condPerm xs conds = filter (allBefore conds) (perms xs)

allBefore :: Eq a => [(a,a)] -> [a] -> Bool
allBefore conds p = and $ map (before p) conds

before :: Eq a => [a] -> (a,a) -> Bool
before p (x, y) = (findIndex (==x) p) < (findIndex (==y) p)
