# gem install pqueue
require 'pqueue'
require 'set'

test = true

if test
  SIZE = 7
  INPUT = '../input/18-sample.txt'
  WAIT = 12
else
  SIZE = 71
  INPUT = '../input/18.txt'
  WAIT = 1024
end

DIRS = [[1,0], [0,1], [-1,0], [0,-1]]

def in_bounds(y, x) = y >= 0 && y < SIZE && x >= 0 && x < SIZE

def make_grid(coords)
  grid = SIZE.times.map { Array.new(SIZE) }
  coords.each_with_index { |(x,y),i| grid[y][x] = i+1 }
  grid
end

def find_path(grid, start_time=0)
  start = [0,0]
  target = [SIZE-1,SIZE-1]

  initial = [start, start_time]
  queue = PQueue.new([initial]) { |a,b| a[0].sum - a[1] > b[0].sum - b[1] }
  visited = Set[]

  until queue.empty? do
    pos,time = queue.pop
    next unless visited.add? pos

    if pos == target
      return time - start_time
    end

    y,x = pos
    DIRS.each { |dy,dx|
      ny, nx = y+dy, x+dx
      next unless in_bounds(ny,nx)

      next_cell = grid[ny][nx]
      next_time = time+1

      next if next_cell && next_time >= next_cell
      queue << [[ny,nx], next_time]
    }
  end
end

input = File.readlines(INPUT).map { _1.split(',').map(&:to_i) }


# Part 1
grid = make_grid(input.take(WAIT))
p find_path(grid, WAIT)


# Part 2
puts input.drop(WAIT).find.with_index { |(x,y),i|
  grid[y][x] = i+WAIT
  !find_path(grid, i+WAIT+1)
}&.join(",")
