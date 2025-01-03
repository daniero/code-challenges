if :test
  INPUT = '../input/20-sample.txt'
  SAVE = 1
else
  INPUT = '../input/20.txt'
  SAVE = 100
end


DIRS = [[0,-1], [1,0], [0,1], [-1,0]]

def in_bounds(grid, y, x) = y >= 0 && y < grid.length && x >= 0 && x < grid[y].length

def find_path(maze)
  target, = maze.filter_map.with_index { |row,y| row.index('E')&.then { |x| [y,x] } }
  pos, = maze.filter_map.with_index { |row,y| row.index('S')&.then { |x| [y,x] } }

  path = {pos=>0}

  1.step do |i|
    pos = DIRS
      .map { pos.zip(_1).map(&:sum) }
      .find { |y,x| in_bounds(maze, y, x) && maze[y][x] != '#' && !path.include?([y,x]) }

    path[pos] = i
    return path if pos == target
  end
end

def find_shortcuts(maze, path, n_cheats)
  # All positions within manhattan distance `n_cheats`:
  cheats = [*0..n_cheats].flat_map { |y| [*0..n_cheats-y].flat_map { |x| [[y,x],[y,-x],[-y,x],[-y,-x]].uniq } } - [[0,0]]

  path.sum { |(y,x),dist|
    cheats.count { |cy,cx|
      ny,nx = y+cy, x+cx
      next unless in_bounds(maze, ny, nx)

      new_dist = path[[ny,nx]]
      next unless new_dist

      saved = new_dist - dist - cy.abs - cx.abs
      saved >= SAVE
    }
  }
end


input = File.readlines(INPUT, chomp: true)

path = find_path(input)
p find_shortcuts(input, path, 2)
p find_shortcuts(input, path, 20)
