import Data.ByteString.Lazy.Char8 as Char8 hiding (isPrefixOf)
import Data.Digest.Pure.MD5
import Data.List

input = "ckczppom"

hashString = show . md5 . Char8.pack

brute s n = let hash = hashString $ s ++ show n
            in if isPrefixOf "00000" hash then n else brute s (n + 1)

main = do
  print $ brute input 1
