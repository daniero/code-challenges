# gem install pqueue
require 'pqueue'
require 'set'

def neighbours(grid, x, y)
  [
    [x,y-1],
    [x+1,y],
    [x,y+1],
    [x-1,y]
  ].select { |m,n|
    n >= 0 &&
    n < grid.size &&
    m >= 0 &&
    m < grid[0].size
  }
end

input = File
  .readlines(ARGV[0] || '../input/15.txt')
  .map { _1.scan(/\d/).map(&:to_i) }

START = [0,0]
TARGET = [input[0].size-1, input.size-1]

initial = [START, 0]
visited = Set[]
queue = PQueue.new([initial]) { |a,b| a.last < b.last }

until queue.empty?
  position, risk = queue.pop

  next unless visited.add?(position)

  if position == TARGET
    p risk
    break
  end

  neighbours(input, *position).each { |x,y|
    queue.push([[x,y], risk + input[y][x]])
  }
end

