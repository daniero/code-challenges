input = File
  .read(ARGV[0] || '../input/05.txt')
  .scan(/\d+/)
  .map(&:to_i)
  .each_slice(4)
  .map { |x| x.each_slice(2).to_a }

# Part 1

def vector2coords(((x1, y1), (x2, y2)))
  xs = x1 > x2 ? x1.downto(x2) : x1.upto(x2)
  ys = y1 > y2 ? y1.downto(y2) : y1.upto(y2)

  if x1 == x2 || y1 == y2
    [*xs].product([*ys])
  else
    [*xs].zip([*ys])
  end
end

straight, diagonal = input.partition { |(x1,y1),(x2,y2)| x1 == x2 || y1 == y2 }

part1 = straight
  .flat_map(&method(:vector2coords))
  .tally

puts part1.values.count { |x| x > 1 }


# Part 2

part2 = diagonal
  .flat_map(&method(:vector2coords))
  .tally

both = part2.merge(part1) { |_,a,b| a+b }

pp both.values.count { |x| x > 1 }
