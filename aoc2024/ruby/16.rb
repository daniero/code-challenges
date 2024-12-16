# gem install pqueue
require 'pqueue'
require 'set'

DIRS = [[0,1], [1,0], [0,-1], [-1,0]]

def go(pos, dir)
  pos.zip(dir).map(&:sum)
end

def find_paths(grid, start, target)
  initial = [start, 0, 0, [start]] #pos, dir, cost, path
  queue = PQueue.new([initial]) { |a,b| a[2] < b[2] }
  visited = {}

  min_cost = nil
  paths = []

  until queue.empty?
    pos,dir,cost,path = queue.pop

    break if min_cost && cost > min_cost
    next if visited[[pos,dir]]&.then { _1 < cost }
    visited[[pos,dir]] = cost

    if pos == target
      min_cost = cost
      paths << path
      next
    end

    y,x = pos
    next if grid[y][x] == '#'

    new_pos = go(pos, DIRS[dir])
    queue.push([new_pos, dir, cost+1, path+[new_pos]])

    [1,-1].each do |turn|
      new_dir = (dir+turn)%4
      queue.push([pos, new_dir, cost+1000, path])
    end
  end
  return [min_cost, paths]
end


input = File.readlines('../input/16-sample2.txt', chomp: true)

start = [input.length-2, 1]
target = [1, input[1].length-2]

cost, paths = find_paths(input, start, target)


p cost
p paths.flatten(1).uniq.size

