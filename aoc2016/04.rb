input = File.open('input/04_input.txt').each_line.map { |line|
  line =~ /([a-z-]+)-(\d+)\[([a-z]+)\]/
  name, id, checksum = $1, $2, $3
  [name, id.to_i, checksum]
}

real_rooms = input.select { |name, _, checksum|
  common_letters = name.delete('-').chars.sort_by { |c| [-name.count(c), c] }.uniq.take(5)
  common_letters.join == checksum
}

# Part 1
p real_rooms.reduce(0) { |sum, (_, id, _)| sum + id }

# Part 2
decrypted = real_rooms.map { |name, id, _|
  decrypted = name.dup
  id.times { decrypted.tr!('a-z-', 'b-za ') }
  "#{decrypted}: #{id}"
}

p decrypted.grep /pole/i
