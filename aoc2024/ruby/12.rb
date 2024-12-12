require 'set'

DIRS = [[0,1],[1,0], [0,-1], [-1,0]]

def in_bounds(grid, y, x) =
  y >= 0 &&
  y < grid.length &&
  x >= 0 &&
  x < grid[y].length


input = File.readlines('../input/12-sample.txt', chomp: true).map(&:chars)

areas = Hash.new { 0 }
perimeters = Hash.new { 0 }
fences = input.map { _1.map { DIRS.map { true } } }

ids = -1
visited = Set[]
queue = [[[0,0], ids+=1]]

until queue.empty? do
  (y,x),id = queue.pop
  next unless visited.add? [y,x]

  areas[id] += 1
  areas[[y,x]] = id

  DIRS.each_with_index do |(dy,dx),dir|
    ny, nx = y+dy, x+dx
    next unless in_bounds input, ny, nx
    next if visited.include? [ny,nx]

    if input[ny][nx] == input[y][x]
      fences[y][x][dir] = false
      fences[ny][nx][(dir+2)%4] = false

      queue.push [[ny,nx], id]
    else
      queue.unshift [[ny,nx], ids+=1]
    end
  end

  perimeters[id] += fences[y][x].count(true)
end


# Part 1:
p (0..ids).sum { |i| areas[i] * perimeters[i] }


# Part 2:
coords = input.map.with_index { |row,y| row.map.with_index { |c,x| [y,x] } }

p coords.sum {
  _1
    .filter { |y,x| fences[y][x][3] }
    .slice_when { |(y1,x1),(y2,x2)| x2 != x1+1 || input[y1][x1] != input[y2][x2] }
    .sum { |coords| areas[areas[coords.first]] }
} +
coords.sum {
  _1
    .filter { |y,x| fences[y][x][1] }
    .slice_when { |(y1,x1),(y2,x2)| x2 != x1+1 || input[y1][x1] != input[y2][x2] }
    .sum { |coords| areas[areas[coords.first]] }
} +
coords.transpose.sum {
  _1
    .filter { |y,x| fences[y][x][2] }
    .slice_when { |(y1,x1),(y2,x2)| y2 != y1+1 || input[y1][x1] != input[y2][x2] }
    .sum { |coords| areas[areas[coords.first]] }
} +
coords.transpose.sum {
  _1
    .filter { |y,x| fences[y][x][0] }
    .slice_when { |(y1,x1),(y2,x2)| y2 != y1+1 || input[y1][x1] != input[y2][x2] }
    .sum { |coords| areas[areas[coords.first]] }
}
