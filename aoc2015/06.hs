import Data.List

allOff :: () -> (Int -> Int -> Bool)
allOff () = (\x y -> False)

isIn x y x1 y1 x2 y2 = x1 <= x && x <= x2 && y1 <= y && y <= y2

tOn :: Int -> Int -> Int -> Int -> (Int -> Int -> Bool) -> (Int -> Int -> Bool)
tOn x1 y1 x2 y2 lights = (\x y -> isIn x y x1 y1 x2 y2 || lights x y)

tOff :: Int -> Int -> Int -> Int -> (Int -> Int -> Bool) -> (Int -> Int -> Bool)
tOff x1 y1 x2 y2 lights = (\x y -> not (isIn x y x1 y1 x2 y2) && lights x y)

toggle :: Int -> Int -> Int -> Int -> (Int -> Int -> Bool) -> (Int -> Int -> Bool)
toggle x1 y1 x2 y2 lights = (\x y -> if (isIn x y x1 y1 x2 y2) then not (lights x y) else (lights x y))

n = 10
start = [ [ allOff | _ <- [1..n] ] | _ <- [1..n] ]

main = do
  let x = allOff ()
      y = tOn 1 1 3 3 x
      z = tOn 5 5 5 5 y
      a = tOff 1 1 3 3 z
      b = toggle 0 0 4 4 a
  print $ x 0 0

  print $ y 0 0
  print $ y 2 2
  print $ z 4 4
  print $ z 5 5
  
  print $ a 2 2
  print $ a 5 5

  print $ b 2 2
  print $ b 5 5
