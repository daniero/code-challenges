INPUT = 793031

scores = [3, 7]
elf1 = 0
elf2 = 1

LIMIT = INPUT + 10
recipies_discovered = scores.size
scores += [-1] * (LIMIT - recipies_discovered)

i = 0
while recipies_discovered < LIMIT do
  print "Iteration: #{i+=1}, Recipies: #{recipies_discovered}\r"

  score1, score2 = scores.values_at(elf1, elf2)

  # puts scores
  #   .map
  #   .with_index { |score, index| index == elf1 ? "(#{score})" : index == elf2 ? "[#{score}]" : " #{score} " }
  #   .join(' ')

  new_recipies = (score1 + score2).digits.reverse
  scores[recipies_discovered, new_recipies.length] = new_recipies
  recipies_discovered += new_recipies.length

  elf1 += score1 + 1
  elf1 %= recipies_discovered
  elf2 += score2 + 1
  elf2 %= recipies_discovered
end

puts "\n"+ scores.last(10).join

