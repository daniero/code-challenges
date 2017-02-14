import Data.List
import Library

limit = 100

neighbours x y = [ (a, b) | i <- [-1..1],
                            j <- [-1..1],
                            i /= 0 || j /= 0,
                            let a = x + i,
                            let b = y + j,
                            0 <= a && a < limit,
                            0 <= b && b < limit ]

light m x y = let n = length $ filter (\(i,j) -> m !! j !! i) $ neighbours x y
                  l = m !! y !! x
               in if l
                  then n == 2 || n == 3
                  else n == 3

tick m = [ [ light m x y | x <- [0..limit-1] ] | y <- [0..limit-1] ]

countLights = length . concatMap (filter (== True))

main = do
  input <- readFile "input/18.txt"
  let l = lines input
  let m = map (map (== '#')) l

  let part1 = (times 100 tick) m
  print $ countLights part1

  let isCorner x y = (x == 0 || x == limit-1) && (y == 0 || y == limit-1)
  let keepCornersOn m = [ [ isCorner x y || m !! y !! x | x <- [0..limit-1] ] |  y <- [0..limit-1] ]
  let part2 = (times 100 (keepCornersOn . tick . keepCornersOn)) m
  print $ countLights part2
