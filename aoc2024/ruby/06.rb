require 'set'

map = File
  .readlines('../input/06-sample.txt')
  .map(&:chomp)

y = map.index { _1[?^] }
x = map[y].index ?^

visited = Set[]

dirs = [ [-1,0], [0,1], [1,0], [0,-1] ]
dir = 0

loop do
  visited << [x,y]

  vy, vx = dirs[dir%4]
  ny, nx = y+vy, x+vx

  break if ny < 0 || ny >= map.length || nx < 0 || nx >= map.first.length

  next_step = map[ny][nx]

  if next_step == '#'
    dir += 1
  else
    y, x = ny, nx
  end
end

p visited.size
