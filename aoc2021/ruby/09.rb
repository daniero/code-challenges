input = File
  .readlines(ARGV[0] || '../input/09.txt')
  .map { |line| line.scan(/\d/).map(&:to_i) }


def neighbour_coords(grid, x, y)
  coords = []
  coords << [x, y-1] if y > 0
  coords << [x+1, y] if x < grid[y].length - 1
  coords << [x, y+1] if y < grid.length - 1
  coords << [x-1, y] if x > 0
  coords
end

def neighbours(grid, x, y)
  neighbour_coords(grid,x,y).map { |i,j| grid[j][i] }
end

# Part 1

p input
  .each_with_index
  .sum { |line, y|
    line
      .select.with_index { |point,x| neighbours(input,x,y).all? { _1 > point } }
      .sum { _1 + 1 }
  }


# Part 2

require 'set'

basins = Set[]

input.each_with_index { |line, y|
  line.each_with_index { |point, x|
    next if point == 9

    neighbour_basins = basins.select { |basin|
      neighbour_coords(input, x,y).any? { |n| basin.include? n }
    }

    basins.subtract(neighbour_basins)
    basins << neighbour_basins.reduce(Set[[x,y]], &:merge)
  }
}

pp basins.map(&:size).sort.reverse.take(3).reduce(:*)
