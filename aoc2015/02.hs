import Data.List.Split

area [l, w, h] = let a = l * w
                     b = w * h
                     c = h * l
                 in 2*a + 2*b + 2*c + minimum [a, b, c]

main = do
    input <- readFile "input/02.txt"
    let packages  = [ [ read x :: Int | x <- splitOn "x" p ] | p <- lines input ]
    let dimensions = map area packages
    print $ sum dimensions
