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

bestByTime reindeers time = maximum $ map ($ time) reindeers

timelimit = 2503

main = do
  input <- readFile "input/14.txt"
  let reindeers = map (\line -> let [x,y,z] = readNumbers line in reindeer x y z) $ lines input
  -- Part 1:
  print $ bestByTime reindeers timelimit 

  -- Part 2:
  let times  = [1..timelimit]
      leaders = map (bestByTime reindeers) times
      reindeerPoints reindeer = (\(time, leader) -> if (reindeer time) == leader then 1 else 0)
      points = map (\reindeer -> sum $ map (reindeerPoints reindeer) $ zip times leaders) reindeers
  print $ maximum points
