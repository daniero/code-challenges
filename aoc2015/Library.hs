module Library where
import Text.Regex.Posix

readNumbers :: String -> [Int]
readNumbers line = let matches = line =~ "[0-9]+" :: AllTextMatches [] String
                       strings = getAllTextMatches matches
                   in map (\x -> read x :: Int) strings
