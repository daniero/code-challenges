input = $<.map(&:to_i)


# Part 1

i = 0
n = 0
jumps = input.dup

while i >= 0 && i < jumps.size
  jump = jumps[i]

  jumps[i] += 1
  i += jump
  n += 1
end

puts n


# Part 2

i = 0
n = 0
jumps = input.dup

while i >= 0 && i < jumps.size
  jump = jumps[i]

  jumps[i] += (jump >= 3) ? -1 : 1
  i += jump
  n += 1
end

puts n
