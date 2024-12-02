input = File
  .readlines('../input/02-sample.txt')
  .map { |line| line.scan(/\d+/).map &:to_i }


# Part 1

pp input
  .count { |r| (r == r.sort || r == r.sort.reverse) && r.each_cons(2).all? { |a,b| s = (a-b).abs; s >= 1 && s <= 3 } }
