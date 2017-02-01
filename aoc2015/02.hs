import Data.List.Split

area [l, w, h] = let a = l * w
                     b = w * h
                     c = h * l
                 in 2*a + 2*b + 2*c + minimum [a, b, c]

ribbon dimensions = (sum dimensions - maximum dimensions) * 2 + product dimensions

main = do
    input <- readFile "input/02.txt"
    let packages  = [ [ read x :: Int | x <- splitOn "x" p ] | p <- lines input ]
-- Part 1:
    print $ sum $ map area packages
-- Part 2:
    print $ sum $ map ribbon packages
