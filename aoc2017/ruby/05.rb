def jumps(input)
  jumps = input.dup
  i = 0
  n = 0

  while i >= 0 && i < jumps.size
    offset = jumps[i]

    jumps[i] = yield offset
    i += offset
    n += 1
  end

  n
end

input = $<.map(&:to_i)

puts jumps(input) { |x| x + 1 }
puts jumps(input) { |x| (x >= 3) ? x - 1 : x + 1 }
