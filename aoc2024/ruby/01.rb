input = File
  .readlines('../input/01-sample.txt')
  .map { |line| line.scan(/\d+/).map &:to_i }


# Part 1

p input.transpose.map(&:sort).transpose.sum { |a,b| (a - b).abs }


# Part 2

a,b = input.transpose
p a.sum { |i| i * b.count(i) }
