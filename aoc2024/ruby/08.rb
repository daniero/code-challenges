input = File
  .readlines('../input/08-sample.txt')
  .map(&:chomp)

positions = Hash.new { |h,k| h[k] = [] }

input.each_with_index { |row,y|
  row.chars.each_with_index { |char,x|
    positions[char] << [x,y] unless char == '.'
  }
}

def in_bounds(input, x, y) =
  y >= 0 &&
  y < input.length &&
  x >= 0 &&
  x < input[y].length


# Part 1

p positions.flat_map { |char,positions|
    positions
      .permutation(2)
      .map { |(x1,y1),(x2,y2)| [2*x1 - x2, 2*y1 - y2] }
      .filter { |nx,ny| in_bounds(input, nx, ny) }
  }
  .uniq
  .size


# Part 2

p positions.flat_map { |char,positions|
    positions.permutation(2).flat_map { |(x1,y1),(x2,y2)|
      dx, dy = x2-x1, y2-y1

      0.step
        .lazy
        .map { |v| [x1 - dx*v, y1 - dy*v] }
        .take_while { |nx,ny| in_bounds(input, nx, ny) }
        .to_a
    }
  }
  .uniq
  .size
