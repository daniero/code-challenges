f '(' = 1
f ')' = -1
f _ = 0

main = do
    input <- readFile "input/01.txt"
    print(sum(map f input))
