input = File
  .readlines('../input/input10.txt')
  .map { |line| line.scan(/-?\d+/).map(&:to_i) }

def boundries(points)
  points
    .transpose
    .take(2)
    .flat_map(&:minmax)
end

def print_grid(points)
  min_x, max_x, min_y, max_y = boundries(points)
  width = max_x - min_x + 1
  height = max_y - min_y + 1

  grid = Array.new(height) { Array.new(width) { 0 } }
  points.each { |x,y,*| grid[y-min_y][x-min_x] = 1 }

  puts grid.map { |row| row.map { |col| " #"[col] }.join }
end

def move(points)
  points.map { |pos_x, pos_y, vel_x, vel_y|
    [pos_x + vel_x, pos_y + vel_y, vel_x, vel_y]
  }
end

points = input.dup
i = 0

loop do
  print "#{i}\r"
  min_x, max_x, min_y, max_y = boundries(points)
  height = max_y - min_y + 1

  break if height <= 10

  points = move(points)
  i += 1
end

puts
print_grid(points)
