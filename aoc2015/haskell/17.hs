import Data.List

subsetsum' sums [] = sums
subsetsum' sums (n : ns) = subsetsum' (sums ++ map (+ n) sums) ns
subsetsum = subsetsum' [0]

subsetsum2 sums [] = sums
subsetsum2 sums (x : xs) = let newSums = map (\(a,b) -> (a+x, b+1)) sums
                            in subsetsum2 (sums ++ newSums) xs

count e = length . filter (== e)

amount = 150

main = do
  input <- readFile "../input/17.txt"
  let containers = map (\line -> read line :: Int) (lines input)

  -- Part 1
  let sums = subsetsum containers
  print $ count amount sums

  -- Part 2
  let sums2 = subsetsum2 [(0,0)] containers
      correct = filter ((== amount) . fst) sums2
      min = minimum $ map snd correct
  print $ length $ filter ((== min) . snd) correct
