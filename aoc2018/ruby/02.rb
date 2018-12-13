box_ids = File.readlines('../input/input02.txt')

# Part 1

letter_counts = box_ids.map do |line|
  ('a'..'z').map { |letter| line.count(letter) }
end

twos = letter_counts.count { |counts| counts.member? 2 }
threes = letter_counts.count { |counts| counts.member? 3 }

puts twos * threes


# Part 2

correct_ids = box_ids.product(box_ids).find do |id1, id2|
  diffs = id1.chars.zip(id2.chars).count { |a,b| a != b }
  diffs == 1
end

puts correct_ids
  .map(&:chars)
  .transpose
  .select { |a,b| a == b }
  .transpose
  .first
  .join
