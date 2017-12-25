import Data.Char
import Data.List

trim :: String -> String
trim = dropWhileEnd isSpace

rotate :: Int -> [a] -> [a]
rotate n xs = take (length xs) $ drop n $ cycle xs

pairs :: Int -> [a] -> [(a, a)]
pairs n xs = zip xs $ rotate n xs

foo (x, y) | x == y    = x
           | otherwise = 0

main = do
  input <- readFile "../input/input01.txt";
  let ns = map digitToInt $ trim input
  -- Part 1:
  print $ sum $ map foo $ pairs 1 ns
  -- Part 2:
  print $ sum $ map foo $ pairs ((length ns) `quot` 2) ns
