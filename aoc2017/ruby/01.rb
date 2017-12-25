input = File.read('../input/input01.txt').scan(/\d/).map(&:to_i)

# Part 1
p input.zip(input.rotate)
  .select { |a,b| a == b }
  .sum(&:first)

# Part 2
p input.zip(input.rotate(input.size/2))
  .select { |a,b| a == b }
  .sum(&:first)
