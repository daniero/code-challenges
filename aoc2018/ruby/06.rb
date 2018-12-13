def manhattan_distance(x1, y1, x2, y2)
  (x1 - x2).abs + (y1 - y2).abs
end

points = File
  .readlines('../input/input06.txt')
  .map { |line| line.scan(/\d+/).map(&:to_i) }

min_x, max_x, min_y, max_y =
  points
    .transpose
    .flat_map(&:minmax)

length = max_x - min_x + 1
height = max_y - min_y + 1

grid = Array.new(height) { Array.new(length) }

(min_y..max_y).each do |y|
  (min_x..max_x).each do |x|
    distances = points.map { |px,py| manhattan_distance(px, py, x, y) }
    min = distances.min
    if distances.count(min) == 1
      grid[y-min_y][x-min_x] = distances.index(min)
    end
  end
end

area_sizes = Hash.new { 0 }

# Skip outer rows
grid[1..-2].each do |row|
  # Skip outer collums
  row[1..-2].each do |nearest_point|
    area_sizes[nearest_point] += 1 if nearest_point
  end
end

p area_sizes.values.max
