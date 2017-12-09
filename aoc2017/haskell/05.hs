import Library

jump n i cells
  | i < 0 || i >= length cells
  = n
  | otherwise
  = let cell = cells !! i
        head = take i cells
        tail = drop (i+1) cells
        next = (head ++ [cell + 1] ++ tail)
    in
      jump (n+1) (i + cell) next

main = do
  input <- readFile "../input05.txt";
  print $ jump 0 0 $ readNumbers input

