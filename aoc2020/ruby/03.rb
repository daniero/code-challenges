map = File
  .readlines('../input/03.txt')
  .map(&:chomp)


# Part 1

p map.each_with_index.count { |line, i|
    line[i * 3 % line.length] == '#'
}


# Part 2

slopes = [
  [1, 1],
  [3, 1],
  [5, 1],
  [7, 1],
  [1, 2]
]

p slopes.map { |right,down|
  map
    .select.with_index { |_, row_index| row_index % down == 0 }
    .each_with_index.count { |row, col_index|
      row[col_index * right % row.length] == '#'
    }
}.reduce(:*)
