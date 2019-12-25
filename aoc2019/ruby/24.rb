require 'set'

GRID_SIZE = 5

def adjacent_cells(x,y)
  cells = []
  cells << [x-1,y] if x > 0
  cells << [x,y-1] if y > 0
  cells << [x+1,y] if x < GRID_SIZE-1
  cells << [x,y+1] if y < GRID_SIZE-1
  cells
end

def tick(grid)
  (0...GRID_SIZE).map { |y|
    (0...GRID_SIZE).map { |x|
      cell = grid[y][x] 
      adjacent = adjacent_cells(x,y).count { |i,j| grid[j][i] == '#' }
      cell == '#' && adjacent == 1 || cell == '.' && adjacent.between?(1,2) ? '#' : '.'
    }
  }
end

def biodiversity(grid)
  (0...GRID_SIZE).sum { |y|
    (0...GRID_SIZE).sum { |x|
      cell = grid[y][x] 
      cell == '#' ? 2**(y*GRID_SIZE+x) : 0
    }
  }
end

grid = File
  .readlines('../input/input24.txt')
  .map { |line| line.chomp.chars }


previous_grids = Set[]

loop do
  seen_before = !previous_grids.add?(grid)
  if seen_before
    p biodiversity(grid)
    break
  end
  grid = tick(grid)
end
