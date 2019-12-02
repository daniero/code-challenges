def part1(m)
  [0, ( m/3-2 )].max
end

def part2(m)
  f = part1(m)

  f <= 2 ? f : f + part2(f)
end

p input = File
  .readlines('input/input01.txt')
  .map(&:to_i)
  .sum { |m| part2(m) }

