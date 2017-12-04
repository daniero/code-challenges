input = File.readlines('../input04.txt').map(&:split)

# Part 1
p input.count { |phrase| phrase == phrase.uniq }

# Part 2
p input.count { |phrase|
  anagrams = phrase.map { |word| word.chars.sort.join }
  anagrams == anagrams.uniq 
}
