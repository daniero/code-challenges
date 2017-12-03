input = "1321131112"

-- Dette går ikke :(
-- http://stackoverflow.com/q/1179008/1373657
-- f (c : c : c : s) = '3' : c : f(s)
-- f (c : c : s) = '2' : c : f(s)
-- f (c : s) = '1' : c : f(s)
-- f ("") = ""

f (a : b : c : s)
  | a == b && b == c = '3' : a : f(s)
f (a : b : s)
  | a == b = '2' : a : f(s)
f (a : s) = '1' : a : f(s)
f (s) = s

times n f = iterate (f .) id !! n

main = do
  print $ length $ (times 40 f) input
  print $ length $ (times 50 f) input
