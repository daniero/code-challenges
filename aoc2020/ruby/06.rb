groups = File
  .read('../input/06.txt')
  .split("\n\n")
  .map { |group| group.lines.map(&:chomp) }


# Part 1

p groups.sum { |group| group.join.chars.uniq.size }
