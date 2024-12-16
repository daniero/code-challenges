# gem install pqueue
require 'pqueue'
require 'set'

DIRS = [[0,1], [1,0], [0,-1], [-1,0]]

def go(grid, pos, dir)
  pos.zip(dir).map(&:sum)
end

def find_path(grid, start, target)
  initial = [start, 0, 0, [start]] #post, dir, cost, path
  queue = PQueue.new([initial]) { |a,b| a[2] < b[2] }

  visited = Set[]

  until queue.empty?
    pos,dir,cost,path = queue.pop

    next unless visited.add? [pos,dir]
    return cost if pos == target

    y,x = pos
    next if grid[y][x] == '#'

    new_pos = go(grid, pos, DIRS[dir])
    queue.push([new_pos, dir, cost+1, path+[new_pos]])

    [1,-1].each do |turn|
      new_dir = (dir+turn)%4
      queue.push([pos, new_dir, cost+1000, path])
    end
  end

  raise "nope"
end


input = File.readlines('../input/16-sample2.txt', chomp: true)

start = [input.length-2, 1]
target = [1, input[1].length-2]

p find_path(input, start, target)
