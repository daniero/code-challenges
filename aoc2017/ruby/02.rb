input = File.open('../input/input02.txt')
  .each_line
  .map { |line| line.scan(/\d+/).map(&:to_i) }

# Part 1
p input.sum { |ns| ns.max - ns.min }

# Part 2
p input.sum { |ns|
  ns.permutation(2)
    .map { |a,b| a.divmod b }
    .sum { |div,mod| mod == 0 ? div : 0 }
}

