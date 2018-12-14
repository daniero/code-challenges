require 'set'

INPUT = 793031

scores = [3, 7]
elf1 = 0
elf2 = 1

i = 0
while scores.size < INPUT + 10 do
  i += 1
  print "Iterations: #{i}, Recipies: #{scores.size}\r"
  index1 = elf1 % scores.size
  index2 = elf2 % scores.size
  score1, score2 = scores.values_at(index1, index2)

  # puts scores
  #   .map
  #   .with_index { |score, index| index == elf1 ? "(#{score})" : index == elf2 ? "[#{score}]" : " #{score} " }
  #   .join(' ')

  scores += (score1 + score2).digits.reverse

  elf1 += score1 + 1
  elf1 %= scores.size
  elf2 += score2 + 1
  elf2 %= scores.size
end

puts "\n"+ scores.last(10).join
