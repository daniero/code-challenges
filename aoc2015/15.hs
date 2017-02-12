import Data.List
import Library

distribute :: Int -> [Int] -> [[Int]]
distribute n (x : []) = [[x + n]]
distribute 0 l = [l]
distribute n (x : xs) = concatMap (\i -> map (\ys -> (x+i) : ys) (distribute (n-i) xs)) [0..n]

teaspoons = 100

combine amounts ingredients = let mix = map (zip ingredients) amounts
                              in map (map (\(ingredient, amount) -> map (*amount) ingredient)) mix

sumProperties = map (max 0 . sum) . transpose
score = product . take 4 . sumProperties

main = do
  input <- readFile "input/15.txt"
  let ingredients = map readNumbers $ lines input
      base = replicate (length ingredients) 0
      amounts = distribute teaspoons base
      combinations = combine amounts ingredients

  print $ maximum $ map score combinations
