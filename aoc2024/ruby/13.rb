def find_intersection(ax, ay, bx, by, tx, ty)
  # Find a and b where:
  #   ax*a + bx*b = tx
  #   ay*a + by*b = ty

  a = (tx*by - ty*bx).to_f / (ax*by - ay*bx)
  b = (ty - ay * a).to_f / by

  return [a, b] if a%1 == 0 && b%1 == 0
end

def solve(input)
  input
    .filter_map { |a, b, target| find_intersection(*a, *b, *target) }
    .sum { |a,b| a * 3 + b }
    .to_i
end


input = File
  .read('../input/13-sample.txt')
  .split("\n\n")
  .map { _1.scan(/\d+/).map(&:to_i).each_slice(2).to_a }


p solve(input)
p solve(input.map { |a, b, target| [a, b, target.map { _1 + 10000000000000}]})
