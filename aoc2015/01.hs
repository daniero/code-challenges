import Data.List

f '(' = 1
f ')' = -1
f _ = 0

main = do
-- Part 1:
    input <- readFile "input/01.txt"
    let x = map f input
    print(sum x)

-- Part 2:
    print(findIndex (<0) (scanl1 (+) (0:x)))

