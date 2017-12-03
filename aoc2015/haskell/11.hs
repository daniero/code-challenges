import Data.Char (ord, chr)

straight (a : b : c : s)
  | (ord a) == (ord b) - 1 && (ord b) == (ord c) -1 = True
  | otherwise                                       = straight (b : c : s)
straight _ = False

confusing (c : s) = elem c "iol" || confusing s
confusing _ = False

pairs n (a : b : s)
  | a == b    = pairs (n - 1) s
  | otherwise = pairs n (b : s)
pairs n _     = n == 0

passwordOk s = straight s && not (confusing s) && pairs 2 s

nextString' []          = ['a']
nextString' ('z':xs)    = 'a' : nextString' xs
nextString' (x:xs)      = succ x : xs
nextString = reverse . nextString' . reverse

nextPassword s = let next = nextString s in
                 if passwordOk next then next
                 else nextPassword next


main = do
  let password = "hxbxwxba"
      part1 = nextPassword password
      part2 = nextPassword part1
  putStrLn part1
  putStrLn part2
