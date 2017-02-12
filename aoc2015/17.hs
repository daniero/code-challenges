import Data.List

subsetsum sums [] = sums
subsetsum sums (n : ns) = subsetsum (sums ++ map (+ n) sums) ns

count e = length . filter (== e)

amount = 150

main = do
  input <- readFile "input/17.txt"
  let containers = map (\line -> read line :: Int) (lines input)
      sums = subsetsum [0] containers
  print $ count amount sums
