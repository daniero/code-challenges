input = File
  .readlines(ARGV[0] || '../input/09.txt')
  .map { |line| line.scan(/\d/).map(&:to_i) }


# Part 1

def neighbours(grid,x,y)
  result = []
  result << grid[y-1][x] if y > 0
  result << grid[y][x+1] if x < grid[y].length - 1
  result << grid[y+1][x] if y < grid.length - 1
  result << grid[y][x-1] if x > 0
  result
end

p input
  .each_with_index
  .sum { |line, y|
    line
      .select.with_index { |point,x| neighbours(input,x,y).all? { _1 > point } }
      .sum { _1 + 1 }
  }
