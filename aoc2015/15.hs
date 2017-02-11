import Data.List

distribute :: Int -> [Int] -> [[Int]]
distribute n (x : []) = [[x + n]]
distribute 0 l = [l]
distribute n (x : xs) = concatMap (\i -> map (\y -> (x+i) : y) (distribute (n-i) xs)) [0..n]

teaspoons = 100
 
main = do
  print $ distribute teaspoons (replicate 4 0)
