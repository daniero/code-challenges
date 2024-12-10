DIRS = [ [0,-1], [1,0], [0,1], [-1,0] ]

def in_bounds(grid, x, y) = y >= 0 && y < grid.length && x >= 0 && x < grid[y].length

def find_trails(grid, v, x, y)
  return [] unless in_bounds(grid, x, y) && grid[y][x] == v
  return [[x,y]] if v == 9

  DIRS
    .map { |dx,dy| [x+dx, y+dy] }
    .flat_map { |nx, ny| find_trails(grid, v+1, nx, ny) }
end


input = File
  .readlines('../input/10-sample.txt', chomp: true)
  .map { _1.chars.map &:to_i }

p input
  .each_with_index
  .sum { |row,y|
    row.each_index.sum { |x| find_trails(input, 0, x, y).size }
  }
