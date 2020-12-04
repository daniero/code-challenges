passports = File
  .read('../input/04.txt')
  .split("\n\n")
  .map { |chunk| chunk.scan(/(\w+):(\S+)/).to_h }

p passports.count { |passport|
  passport.size == 8 ||
  passport.size == 7 && !passport.has_key?('cid')
}
