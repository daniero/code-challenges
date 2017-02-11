import Text.Regex.Posix

readNumbers :: String -> [Int]
readNumbers line = let matches = line =~ "[0-9]+" :: AllTextMatches [] String
                       strings = getAllTextMatches matches
                   in map (\x -> read x :: Int) strings

reindeer :: Int -> Int -> Int -> (Int -> Int)
reindeer speed boost rest = let period = boost + rest
                                boostPrPeriod = speed * boost
                            in (\n -> let periods = div n period
                                          lastPeriod = minimum [mod n period, boost]
                                      in boostPrPeriod * periods + lastPeriod * speed)

time = 2503

main = do
  input <- readFile "input/14.txt"
  let reindeers = map (\line -> let [x,y,z] = readNumbers line in reindeer x y z) $ lines input
  print $ maximum $ map ($ time) reindeers
