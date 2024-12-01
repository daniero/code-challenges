input = File
  .readlines('../input/01-sample.txt')
  .map { |line| line.scan(/\d+/).map &:to_i }


# Part 1

pp input.transpose.map(&:sort).transpose.sum { |a,b| (a - b).abs }
