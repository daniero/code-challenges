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
    break if pos == target
  end

  path
end

def find_shortcuts(path, maze)
  path.flat_map { |(y,x),dist|
    DIRS.filter_map { |dy,dx|
      ay,ax = y+dy, x+dx
      by,bx = y+dy*2, x+dx*2
      next unless in_bounds(maze, by, bx) && maze[ay][ax] == '#' && maze[by][bx] != '#'

      new_dist = path[[by,bx]]
      next if new_dist < dist+2
      path.keys.take(dist+1) + [[ay,ax]] + path.keys.drop(new_dist)
    }
  }
end


input = File.readlines('../input/20.txt', chomp: true)
start = input.filter_map.with_index { |row,y| row.index('S')&.then { |x| [y,x] } }

path = find_path(input)
shortcuts = find_shortcuts(path, input)

p shortcuts.count { path.size - _1.size >= 100 }
