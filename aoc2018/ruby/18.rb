input = File
  .readlines('../input/input18.txt')
  .map(&:chomp)
  .map(&:chars)

def adjecent_squares(x,y, grid)
  [
    [x-1, y-1],
    [x, y-1],
    [x+1, y-1],
    [x-1, y],
    [x+1, y],
    [x-1, y+1],
    [x, y+1],
    [x+1, y+1]
  ]
    .select { |i,j| i >= 0 && i < grid[y].length && j >= 0 && j < grid.length }
    .map { |i,j| grid[j][i] }
end

def tick(grid)
  grid.map.with_index do |row, y|
    row.map.with_index do |cell, x|
      adjecent_squares = adjecent_squares(x,y, grid)
      case cell
      when '.'
        adjecent_squares.count('|') >= 3 ? '|' : '.'
      when '|'
        adjecent_squares.count('#') >= 3 ? '#' : '|'
      when '#'
        adjecent_squares.count('#') >= 1 &&
          adjecent_squares.count('|') >= 1 ? '#' : '.'
      end
    end
  end
end

# Part 1

grid = input

10.times do
  grid = tick(grid)
end

p grid.flatten.count('#') * grid.flatten.count('|')

# Part 2

N = 1000000000

grid = input
visited = { grid.join => 0 }

cycle_start = nil
cycle_end = nil

1.step do |i|
  grid = tick(grid)
  flat = grid.join
  v = visited[flat]

  if v
    cycle_start = v
    cycle_end = i
    break
  end
  visited[flat] = i
end

cycle_length = cycle_end - cycle_start

rem = (N-cycle_start) % cycle_length

rem.times do
  grid = tick(grid)
end

p grid.count('#') * grid.count('|')
