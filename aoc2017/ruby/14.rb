require_relative '10'
require 'set'

INPUT = 'uugsqrei'

RANGE = 0..127
grid = RANGE.map { |i| knot_hash("#{INPUT}-#{i}").to_i(16) }

# Part 1

p grid.sum { |row| RANGE.sum { |col| row[col] } }

# Part 2

def adjecent(x,y)
  [[x,y-1], [x+1, y], [x, y+1], [x-1,y]]
    .select { |i,j| RANGE.cover?(i) && RANGE.cover?(j) }
end

def find_region(grid, x, y, region=Set.new)
  return region if grid[y][x] == 0 || region.include?([x,y])

  region << [x,y]
  adjecent(x,y).each { |i,j| find_region(grid, i, j, region) }
  region
end

coordinates = [*RANGE].product([*RANGE])

p coordinates.each_with_object(Set.new).count { |(x,y), visited|
  next if visited.include? [x,y]

  region = find_region(grid, x, y)
  next if region.empty?

  visited.merge(region)
}
