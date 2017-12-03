import Data.ByteString.Lazy.Char8 as Char8 hiding (isPrefixOf)
import Data.Digest.Pure.MD5
import Data.List

input = "ckczppom"

hashString = show . md5 . Char8.pack

brute s n prefix = let hash = hashString $ s ++ show n
                   in if isPrefixOf prefix hash
                   then n
                   else brute s (n + 1) prefix

main = do
  let part1 = brute input 1 "00000" 
  print part1
  let part2 = brute input part1 "000000" 
  print part2
