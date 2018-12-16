def manhattan_distance(x1, y1, x2, y2)
  (x1 - x2).abs + (y1 - y2).abs
end

def fill_grid(points)
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

      grid[y-min_y][x-min_x] = yield distances
    end
  end

  return grid
end

points = File
  .readlines('../input/input06.txt')
  .map { |line| line.scan(/\d+/).map(&:to_i) }

# Part 1

grid = fill_grid(points) { |distances|
  min_distance = distances.min
  distances.count(min_distance) == 1 && distances.index(min_distance)
}

top_row = grid.first
bottom_row = grid.last
left_col = grid.transpose.first
right_col = grid.transpose.last

edges = top_row + bottom_row + left_col + right_col
areas_touching_edges = edges.compact.uniq

area_sizes = Hash.new { 0 }

grid.each do |row|
  row.each do |nearest_point|
    if nearest_point && !areas_touching_edges.include?(nearest_point)
      area_sizes[nearest_point] += 1
    end
  end
end

p area_sizes.values.max

# Part 2

p fill_grid(points) { |distances| distances.sum < 10000 }
  .flatten
  .count(&:itself)

