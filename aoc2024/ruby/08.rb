input = File
  .readlines('../input/08-sample.txt')
  .map(&:chomp)

positions = Hash.new { |h,k| h[k] = [] }

input.each_with_index { |row,y|
  row.chars.each_with_index { |char,x|
    positions[char] << [x,y] unless char == '.'
  }
}


# Part 1

p positions.flat_map { |char,positions|
    positions.permutation(2).map { |(x1,y1),(x2,y2)|
      [2*x1 - x2, 2*y1 - y2]
    }.filter { |nx,ny|
      ny >= 0 && ny < input.length && nx >= 0 && nx < input.first.length
    }
  }
  .uniq
  .size
