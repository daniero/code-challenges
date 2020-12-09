input = File
  .readlines('../input/09.txt')
  .map(&:to_i)


part1 =
  input
    .each_cons(25+1)
    .find { |*prev, current| prev.combination(2).none? { |a,b| a + b == current } }
    .last

puts part1


part2 =
  [*0...input.length]
    .combination(2)
    .lazy
    .map { |a,b| input[a..b] }
    .find { |range| range.sum == part1 }

puts part2.minmax.sum
