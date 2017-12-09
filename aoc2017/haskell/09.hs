import Data.Char

-- n: Current number of groups already processed and counted
-- d: Depth of current group being processed

group n d ('{' : s) = group n (d+1) s
group n d ('}' : s) = group (n+d) (d-1) s
group n d ('<' : s) = garbage n d s
group n d (_ : s) = group n d s
group n d "" = n

garbage n d ('!' : _ : s) = garbage n d s
garbage n d ('>' : s) = group n d s
garbage n d (_ : s) = garbage n d s

main = do
  input <- readFile "../input09.txt";
  print $ group 0 0 input
