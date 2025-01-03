SAVE = 100

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

def find_shortcuts(maze, path)
  path.sum { |(y,x),dist|
    DIRS.count { |dy,dx|
      ay,ax = y+dy, x+dx
      by,bx = y+dy*2, x+dx*2
      next unless in_bounds(maze, by, bx) && maze[ay][ax] == '#' && maze[by][bx] != '#'

      new_dist = path[[by,bx]]
      saved = new_dist - dist - 2
      saved >= SAVE
    }
  }
end


input = File.readlines('../input/20.txt', chomp: true)

path = find_path(input)
p find_shortcuts(input, path)
