import Data.List

direction '^' = (0, 1)
direction '>' = (1, 0)
direction 'v' = (0, -1)
direction '<' = (-1, 0)
direction _ = (0, 0)

go ((startX, startY), path) (moveX, moveY) = do
    let (lastX, lastY) = last path
        next = (startX + moveX, startY + moveY)
    (next, path ++ [next])

visited directions = do
    let start = ((0, 0), [(0, 0)])
        ((x, y), visited) = foldl go start directions
    visited

main = do
    input <- readFile "input/03.txt"
    let directions = map direction input
    print $ length $ nub $ visited directions
