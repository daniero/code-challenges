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

# Part 1

points = input.dup

# Don't print while the grid is too large
loop do
  min_x, max_x, min_y, max_y = boundries(input)
  height = max_y - min_y

  break if height < 20

  input = move(input)
end

loop do |i|
  puts
  puts '---'
  puts
  print_grid(input)
  input = move(input)
  sleep 0.7
end

