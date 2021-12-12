# gem install pqueue
require 'pqueue'
require 'set'

def each_neighbour(grid, (x, y))
  yield [x, y-1] if y > 0
  yield [x+1, y] if x+1 < grid[y].size
  yield [x, y+1] if y+1 < grid.size
  yield [x-1, y] if x > 0
end

input = File
  .readlines(ARGV[0] || '../input/15.txt')
  .map { _1.scan(/\d/).map(&:to_i) }

def find_path(grid)
  start = [0,0]
  target = [grid[0].size-1, grid.size-1]

  visited = Set[]
  initial = [start, 0]
  queue = PQueue.new([initial]) { |a,b| a.last < b.last }

  until queue.empty?
    position, risk = queue.pop

    next unless visited.add?(position)
    return risk if position == target

    each_neighbour(grid, position) { |x,y|
      queue.push([[x,y], risk + grid[y][x]])
    }
  end
end

# Part 1

puts find_path(input)

# Part 2

large_grid = 5.times.flat_map { |ny|
  input.map { |row|
    5.times.flat_map { |nx|
      row.map { |risk|
        new_risk = risk + ny+nx
        new_risk -= 9 while new_risk > 9
        new_risk
      }
    }
  }
}

p find_path(large_grid)

