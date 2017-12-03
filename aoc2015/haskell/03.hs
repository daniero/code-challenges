import Data.List

direction '^' = (0, 1)
direction '>' = (1, 0)
direction 'v' = (0, -1)
direction '<' = (-1, 0)
direction _ = (0, 0)

go ((startX, startY), path) (moveX, moveY) =
    let next = (startX + moveX, startY + moveY)
    in (next, path ++ [next])

visited directions = do
    let start = ((0, 0), [(0, 0)])
        ((x, y), visited) = foldl go start directions
    visited

split [] = ([], [])
split [x] = ([x], [])
split (x:y:rest) = (x:restX, y:restY) where (restX, restY) = split rest

main = do
    input <- readFile "../input/03.txt"
    let directions = map direction input

    -- Part 1:
    print $ length $ nub $ visited directions

    -- Part 2:
    let (santa, robot) = split directions
    print $ length $ nub $ visited santa ++ visited robot
