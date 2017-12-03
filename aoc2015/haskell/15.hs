import Data.List
import Library

distribute :: Int -> [Int] -> [[Int]]
distribute n (x : []) = [[x + n]]
distribute 0 l = [l]
distribute n (x : xs) = concatMap (\i -> map (\ys -> (x+i) : ys) (distribute (n-i) xs)) [0..n]

combine amounts ingredients = let mix = map (zip ingredients) amounts
                              in map (map (\(ingredient, amount) -> map (*amount) ingredient)) mix

sumProperties = map (max 0 . sum) . transpose
score = product . take 4 . sumProperties

teaspoons = 100

main = do
  input <- readFile "../input/15.txt"
  let ingredients = map readNumbers $ lines input
      base = replicate (length ingredients) 0
      amounts = distribute teaspoons base
      combinations = combine amounts ingredients

  -- Part 1
  print $ maximum $ map score combinations

  -- Part 2
  let lowCalories = filter ((500 <=) . last . sumProperties) combinations
  print $ maximum $ map score lowCalories
