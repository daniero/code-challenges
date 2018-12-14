def find_recipes
  scores = [3, 7]
  elf1 = 0
  elf2 = 1

  loop do
    score1, score2 = scores.values_at(elf1, elf2)

    sum = score1 + score2
    if sum >= 10
      recipe1, recipe2 = sum.divmod(10)
      scores.push(recipe1)
      break if yield scores.size, recipe1
      scores.push(recipe2)
      break if yield scores.size, recipe2
    else
      scores.push(sum)
      break if yield scores.size, sum
    end


    elf1 = (elf1 + score1 + 1) % scores.size
    elf2 = (elf2 + score2 + 1) % scores.size
  end

  return scores, scores.size
end

INPUT = 793031

# Part 1

N = 10
LIMIT = INPUT + N

scores, total_amount = find_recipes { |current_amount, _|
  current_amount == LIMIT 
}

puts "Part 1: " + scores[total_amount-N, N].join

# Part 2

magnitude = 10 ** INPUT.digits.length
buffer = 0

find_recipes do |current_amount, score|
  buffer = (buffer * 10) % magnitude + score

  if buffer == INPUT
    answer = current_amount - INPUT.digits.length
    puts "Part 2: #{answer}"
    true
  end
end
