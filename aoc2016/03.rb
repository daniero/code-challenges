check_triangle = ->(tuple) { a,b,c = tuple.sort; a + b > c }

input = File.readlines('input/03_input.txt').map { |line| line.split.map(&:to_i) }

# Part 1
p input.count(&check_triangle)

# Part 2
p input
  .each_slice(3)
  .flat_map(&:transpose)
  .count(&check_triangle)
