def decompressed_size(string)
  match = (string =~ /\((\d+)x(\d+)\)/)
  return string.size unless match

  chars, repeat = [$1, $2].map(&:to_i)

  $`.size + (chars * repeat) + decompressed_size($'[chars..-1])
end

def decompressed_size_v2(string, mem={})
  return mem[string] if mem.has_key? string

  match = (string =~ /\((\d+)x(\d+)\)/)
  return string.size unless match

  chars, repeat = [$1, $2].map(&:to_i)
  sub = $'[0, chars]

  mem[string] =
    match +
    decompressed_size_v2(sub * repeat, mem) +
    decompressed_size_v2($'[chars..-1], mem)
end

p decompressed_size(File.read('09_input.txt').strip)
p decompressed_size_v2(File.read('09_input.txt').strip)
