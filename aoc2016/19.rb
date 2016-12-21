INPUT = 3014387

# Part 1

elves = (1..INPUT).to_a

while elves.length > 1
  rest = elves.length % 2
  elves.select!.with_index { |_, i| i.even? }
  elves.shift(rest)
end

puts elves.first
