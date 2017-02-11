import Text.Regex.Posix

main = do
  input <- readFile "input/12.json"
  let matches = input =~ "-?[0-9]+" :: AllTextMatches [] String
      strings = getAllTextMatches matches
      numbers = map (\x -> read x :: Int) strings
  print $ sum numbers
