import qualified Data.Set as Set

type Value    = String		-- type stored in vertices
type Edges    = [[Int]]
type Graph    = ([Value], Edges)
type Vertex   = Int
type Vertices = Set.Set Vertex

-- vertex value getter
valueOf :: Graph -> Vertex -> Value
valueOf g i = (valuesOf g) !! i

-- graph-values getter
valuesOf :: Graph -> [Value]
valuesOf = fst

-- graph-edges getter
edgesOf :: Graph -> Edges
edgesOf = snd

-- sample graph - vertices index from 0
-- graph is tuple of 1) list of values; 2) list of list of neighbours
-- graph must be valid!
sampleG :: Graph
sampleG = ( ["a0", "b1", "c2", "d3", "e4", "f5"], [ [4], [2,3,5], [3,4], [1], [0], [1] ])

-- sample bidirectional tree - vertices index from 0
-- 0 -|
--    |- 1
--    |  |- 3 -|
--    |  |     |- 6
--    |  |     |- 7
--    |  |     |- 8
--    |  |- 4
--    |
--    |- 2
--       |- 5
--          |- 9
sampleT :: Graph
sampleT = ( ["a0", "b1", "c2", "d3", "e4", "f5", "g6", "h7", "i8", "j9"], [ [1,2], [0,3,4], [0,5], [1,6,7,8], [1], [2,9], [3], [3], [3], [5] ])


-- bfs <start-vertex id> <graph> <vertex-value function>
-- > bfs 5 sampleG id
-- ["f5","b1","c2","d3","e4","a0"]
-- > bfs 0 sampleT id
-- ["a0","b1","c2","d3","e4","f5","g6","h7","i8","j9"]
bfs :: Int -> Graph -> (Value -> a) -> [a]
bfs start g f = wave (Set.singleton start) g f (Set.singleton start)

-- proccess one wave and run another
wave :: Vertices -> Graph -> (Value -> a) -> Vertices -> [a]
wave verts g f visited | Set.toList verts == [] = []
                       | otherwise              = (waveResults verts g f) ++ (wave (waveNeighbours verts g visited) g f (newVisited verts g visited))

-- results of vertices in this wave
-- > waveResults (Set.fromList [1,2,5]) sampleG id
-- ["b1","c2","f5"]
waveResults :: Vertices -> Graph -> (Value -> a) -> [a]
waveResults verts g f = map (\ v -> f $ valueOf g v) (Set.toList verts)

-- visited vertices after this wave is proceeded
-- > newVisited (Set.fromList [2]) sampleG (Set.fromList [1])
-- fromList [1,3,4]
newVisited :: Vertices -> Graph -> Vertices -> Vertices
newVisited verts g visited = Set.union visited (waveNeighbours verts g visited)

-- yet unvisited vertices of this wave
-- > waveNeighbours  (Set.fromList [0..5]) sampleG (Set.fromList [3,5])
-- fromList [0,1,2,4]
waveNeighbours :: Vertices -> Graph -> Vertices -> Vertices
waveNeighbours verts g visited = Set.fold (\ x xs -> Set.union (vertexNeigbours g visited x) xs) Set.empty verts

-- yet unvisited vertices of particular vertex
-- > vertexNeigbours sampleG (Set.fromList [3,4,7]) 1
-- fromList [2,5]
vertexNeigbours :: Graph -> Vertices -> Vertex -> Vertices
vertexNeigbours g visited w = Set.filter (\ u -> Set.notMember u visited) (Set.fromList ((edgesOf g)!!w))
