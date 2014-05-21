
data Tree a = Node a (Tree a) (Tree a) | Leaf a deriving Show


fromSortedList :: [a] -> Tree a
fromSortedList s = foldl mkTree Leaf (divide 1 s)
    where mkTree l (n:ns) = Node n l (fromSortedList ns)
          divide _ [] = []
          divide c xs = take c xs : divide (c*2) (drop c xs)

toSortedList :: Tree a -> [a]
toSortedList Leaf            = []
toSortedList (Node val l r) = (toSortedList l) ++ [val] ++ (toSortedList r)

intervalFilter :: Ord a => Tree a -> a -> a -> Tree a
intervalFilter t l u = fromSortedList $ filter (\ x -> l <= x && x <= u) (toSortedList t)

foldT :: (a->b->b) -> ([b] -> b) -> b -> Tree a -> b
foldl f g z (Leaf)
