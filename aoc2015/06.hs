import Data.List
import Library

start () = (\x y -> False)

isIn x y x1 y1 x2 y2 = x1 <= x && x <= x2 && y1 <= y && y <= y2

on x1 y1 x2 y2 lights = (\x y -> isIn x y x1 y1 x2 y2 || lights x y)

off x1 y1 x2 y2 lights = (\x y -> not (isIn x y x1 y1 x2 y2) && lights x y)

toggle x1 y1 x2 y2 lights = (\x y -> if (isIn x y x1 y1 x2 y2) then not (lights x y) else (lights x y))

parseLine line = let [x1, y1, x2, y2] = readNumbers line
                 in case line of
                      _ | isPrefixOf "turn on" line -> on x1 y1 x2 y2
                      _ | isPrefixOf "turn off" line -> off x1 y1 x2 y2
                      _ | isPrefixOf "toggle" line -> toggle x1 y1 x2 y2

n = 1000

main = do
  input <- readFile "input/06.txt"
  let commands = lines input
      init = start ()
      lights = foldl (\fn line -> parseLine line fn) init commands

      coords = [(x,y) | x <- [0..n-1], y <- [0..n-1]]

  print $ length $ filter (\(x,y) -> lights x y) coords
