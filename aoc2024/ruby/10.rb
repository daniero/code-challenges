DIRS = [[0,-1], [1,0], [0,1], [-1,0]]

def in_bounds(grid, x, y) =
  y >= 0 &&
  y < grid.length &&
  x >= 0 &&
  x < grid[y].length

def find_trails(grid, x, y, v=0, steps=[[x,y]])
  return [] unless in_bounds(grid, x, y) && grid[y][x] == v
  return [steps] if v == 9

  return DIRS
    .map { |dx,dy| [x+dx, y+dy] }
    .flat_map { |nx, ny| find_trails(grid, nx, ny, v+1, [*steps, [nx,ny]]) }
end


input = File
  .readlines('../input/10-sample.txt', chomp: true)
  .map { _1.chars.map &:to_i }

trails = input.flat_map.with_index { |row,y|
  row.each_index.flat_map { |x| find_trails(input, x, y) }
}

p trails.group_by(&:first).sum { |_,trail| trail.map(&:last).uniq.size }
p trails.size
