input = File.readlines('../input-real06.txt')
input = File.readlines('../input-sample06.txt')

print "Part 1: "
p input
  .map(&:split)
  .transpose
  .sum { |*numbers, operator|
    numbers.map(&:to_i).reduce(&operator.to_sym)
  }


print "Part 2: "
p input
  .map(&:chars)
  .transpose
  .map(&:join)
  .reverse
  .join
  .strip
  .gsub(/((\d+\s*)+)([+*])/) { "(#{$1.split.join($3)})" }
  .split
  .join(" + ")
  .then { eval it }
