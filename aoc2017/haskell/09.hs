-- n: Current number of groups already processed and counted
-- d: Depth of current group being processed

countGroups n d ('{' : s) = countGroups n (d+1) s
countGroups n d ('}' : s) = countGroups (n+d) (d-1) s
countGroups n d ('<' : s) = skipGarbage n d s
countGroups n d (_ : s) = countGroups n d s
countGroups n d "" = n

skipGarbage n d ('!' : _ : s) = skipGarbage n d s
skipGarbage n d ('>' : s) = countGroups n d s
skipGarbage n d (_ : s) = skipGarbage n d s

-- m: Current amount of garbage found

findGarbage m ('<' : s ) = collectGarbage m s
findGarbage m (_ : s ) = findGarbage m s
findGarbage m "" = m

collectGarbage m ('>' : s) = findGarbage m s
collectGarbage m ('!' : _ : s) = collectGarbage m s
collectGarbage m (_ : s) = collectGarbage (m+1) s

main = do
  input <- readFile "../input09.txt";
  print $ countGroups 0 0 input
  print $ findGarbage 0 input
