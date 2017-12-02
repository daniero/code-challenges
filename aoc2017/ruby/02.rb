input = File.open('../input02.txt')
  .each_line
  .map { |line| line.scan(/\d+/).map(&:to_i) }

# Part 1
p input.sum { |ns| ns.max - ns.min }

