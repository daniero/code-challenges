map = File
  .readlines('../input/06-sample.txt')
  .map(&:chomp)

y = map.index { _1[?^] }
x = map[y].index ?^

def run(map, x, y)
  dirs = [ [-1,0], [0,1], [1,0], [0,-1] ]
  dir = 0

  visited = {}

  loop do
   (visited[[x,y]] ||= []) << dir%4

    vy, vx = dirs[dir%4]
    ny, nx = y+vy, x+vx

    if ny < 0 || ny >= map.length || nx < 0 || nx >= map.first.length
      return visited, :out
    elsif visited[[nx,ny]]&.include? dir%4
      return visited, :loop
    elsif map[ny][nx] == '#'
      dir += 1
    else
      y, x = ny, nx
    end
  end
end

# Part 1
visited,_ = run(map, x,y)
p visited.values.reject(&:empty?).count

# Part 2
p (visited.keys - [x,y]).count { |vx,vy|
  row = map[vy]
  new_row = [row[0...vx] + '#' + row[vx+1..]]
  new_map = map[0...vy] + new_row + map[vy+1..]

  _,foo = run(new_map,x,y)
  foo == :loop
}
