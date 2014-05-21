
import Data.List

type Matrix = (Int, Int, [(Int, Int, Int)])

transp :: Matrix -> Matrix
transp (mm, nn, ee) = (nn, mm, e)
         where e = map flipEl ee

flipEl :: (Int, Int, Int) -> (Int, Int, Int)
flipEl (i,j,a) = (j,i,a)


multi :: Matrix -> Matrix -> Matrix
multi mat1@(m1, n1, e1) mat2@(m2, n2, e2) | n1 /= m2 = error "wrong"
                                          | otherwise = (m1, n2, e)
     where e             = filter (\ (_,_,v) -> v /=0) $ map scalarP (zip [1..m1] [1..n2])
           scalarP (i,j) = (i, j, (val i j))
           val i j       = sum $ map (\ ((_,_,x), (_,_,y)) -> x*y) (zip (row mat1 i) (col mat2 j))


row :: Matrix -> Int -> [(Int, Int, Int)]
row (m,n,e) i = unionBy sameAs ready [(i,v,0) | v <- [1..n]]
	where ready = filter (\ (x,_,_) -> x==i) e
	      sameAs (x, y, _) (u, v, _) = x==u && y==v

col :: Matrix -> Int -> [(Int, Int, Int)]
col mat j = map flipEl (row (transp mat) j)
